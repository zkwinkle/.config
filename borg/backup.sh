#!/usr/bin/env bash
# Nightly backup of $HOME to rsync.net. Driven by borg-backup.service, which
# supplies BORG_REPO, BORG_PASSCOMMAND and BORG_RSH from ~/.config/borg/env.
#
# borg's exit codes: 0 = ok, 1 = warning (e.g. a file vanished mid-read, which
# could happen on a live home directory), >=2 = real error. Warnings dont mark
# the unit failed.
set -uo pipefail

CONF="$HOME/.config/borg"

borg create \
  --verbose --stats --show-rc \
  --compression auto,zstd,3 \
  --exclude-from "$CONF/exclude" \
  --one-file-system \
  ::'{hostname}-{now:%Y-%m-%d}' \
  "$HOME"
create_rc=$?

borg prune \
  --list --show-rc \
  --glob-archives '{hostname}-*' \
  --keep-daily 7 --keep-weekly 4 --keep-monthly 6
prune_rc=$?

borg compact
compact_rc=$?

worst=$(( create_rc > prune_rc ? create_rc : prune_rc ))
worst=$(( worst > compact_rc ? worst : compact_rc ))

if [ "$worst" -ge 2 ]; then
  echo "borg failed (rc=$worst)" >&2
  exit "$worst"
fi
if [ "$worst" -eq 1 ]; then
  echo "borg completed with warnings"
fi
exit 0
