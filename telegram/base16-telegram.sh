#!/usr/bin/env bash

# Script was adapted from wal-telegram (https://github.com/guillaumeboehm/wal-telegram)

DEST="${XDG_CONFIG_HOME}/telegram"
PALETTE_FILE="${XDG_CONFIG_HOME}/flavours/common/colors.sh"

source $PALETTE_FILE

color0=$base00
color1=$base08
color2=$base0F
color3=$base0B
color4=$base0C
color5=$base0D
color6=$base06
color7=$base07
color8=$base0A

# Lighten/darken by 20%, 30%, 40%, 50%, 60% some colors using only pure bash.
create_colors() {
  colors=(0 1 2 3 4 5 6 7)
  for i in "${colors[@]}"; do
    color="color${i}"
    c_rgb_12d="$(( 0x"${!color:1:2}" ))"
    c_rgb_34d="$(( 0x"${!color:3:2}" ))"
    c_rgb_56d="$(( 0x"${!color:5:2}" ))"
    c_rgb_12d_20l="$(( c_rgb_12d + "$((c_rgb_12d / 5))" ))"
    c_rgb_34d_20l="$(( c_rgb_34d + "$((c_rgb_34d / 5))" ))"
    c_rgb_56d_20l="$(( c_rgb_56d + "$((c_rgb_56d / 5))" ))"
    [[ "${c_rgb_12d_20l}" -ge 255 ]] && c_rgb_12d_20l=255
    [[ "${c_rgb_34d_20l}" -ge 255 ]] && c_rgb_34d_20l=255
    [[ "${c_rgb_56d_20l}" -ge 255 ]] && c_rgb_56d_20l=255
    printf -v c_hex_12d_20l '%x' "$c_rgb_12d_20l"
    printf -v c_hex_34d_20l '%x' "$c_rgb_34d_20l"
    printf -v c_hex_56d_20l '%x' "$c_rgb_56d_20l"
    [[ "${#c_hex_12d_20l}" -eq 1 ]] && c_hex_12d_20l="0${c_hex_12d_20l}"
    [[ "${#c_hex_34d_20l}" -eq 1 ]] && c_hex_34d_20l="0${c_hex_34d_20l}"
    [[ "${#c_hex_56d_20l}" -eq 1 ]] && c_hex_56d_20l="0${c_hex_56d_20l}"
    c_hex_20l="#${c_hex_12d_20l}${c_hex_34d_20l}${c_hex_56d_20l}"
    declare -g color"${i}"_lighter_20="$c_hex_20l"
    c_rgb_12d_30l="$(( c_rgb_12d + "$((c_rgb_12d * 3 / 10))" ))"
    c_rgb_34d_30l="$(( c_rgb_34d + "$((c_rgb_34d * 3 / 10))" ))"
    c_rgb_56d_30l="$(( c_rgb_56d + "$((c_rgb_56d * 3 / 10))" ))"
    [[ "${c_rgb_12d_30l}" -ge 255 ]] && c_rgb_12d_30l=255
    [[ "${c_rgb_34d_30l}" -ge 255 ]] && c_rgb_34d_30l=255
    [[ "${c_rgb_56d_30l}" -ge 255 ]] && c_rgb_56d_30l=255
    printf -v c_hex_12d_30l '%x' "$c_rgb_12d_30l"
    printf -v c_hex_34d_30l '%x' "$c_rgb_34d_30l"
    printf -v c_hex_56d_30l '%x' "$c_rgb_56d_30l"
    [[ "${#c_hex_12d_30l}" -eq 1 ]] && c_hex_12d_30l="0${c_hex_12d_30l}"
    [[ "${#c_hex_34d_30l}" -eq 1 ]] && c_hex_34d_30l="0${c_hex_34d_30l}"
    [[ "${#c_hex_56d_30l}" -eq 1 ]] && c_hex_56d_30l="0${c_hex_56d_30l}"
    c_hex_30l="#${c_hex_12d_30l}${c_hex_34d_30l}${c_hex_56d_30l}"
    declare -g color"${i}"_lighter_30="$c_hex_30l"
    c_rgb_12d_40l="$(( c_rgb_12d + "$((c_rgb_12d * 2 / 5))" ))"
    c_rgb_34d_40l="$(( c_rgb_34d + "$((c_rgb_34d * 2 / 5))" ))"
    c_rgb_56d_40l="$(( c_rgb_56d + "$((c_rgb_56d * 2 / 5))" ))"
    [[ "${c_rgb_12d_40l}" -ge 255 ]] && c_rgb_12d_40l=255
    [[ "${c_rgb_34d_40l}" -ge 255 ]] && c_rgb_34d_40l=255
    [[ "${c_rgb_56d_40l}" -ge 255 ]] && c_rgb_56d_40l=255
    printf -v c_hex_12d_40l '%x' "$c_rgb_12d_40l"
    printf -v c_hex_34d_40l '%x' "$c_rgb_34d_40l"
    printf -v c_hex_56d_40l '%x' "$c_rgb_56d_40l"
    [[ "${#c_hex_12d_40l}" -eq 1 ]] && c_hex_12d_40l="0${c_hex_12d_40l}"
    [[ "${#c_hex_34d_40l}" -eq 1 ]] && c_hex_34d_40l="0${c_hex_34d_40l}"
    [[ "${#c_hex_56d_40l}" -eq 1 ]] && c_hex_56d_40l="0${c_hex_56d_40l}"
    c_hex_40l="#${c_hex_12d_40l}${c_hex_34d_40l}${c_hex_56d_40l}"
    declare -g color"${i}"_lighter_40="$c_hex_40l"
    c_rgb_12d_50l="$(( c_rgb_12d + "$((c_rgb_12d / 2))" ))"
    c_rgb_34d_50l="$(( c_rgb_34d + "$((c_rgb_34d / 2))" ))"
    c_rgb_56d_50l="$(( c_rgb_56d + "$((c_rgb_56d / 2))" ))"
    [[ "${c_rgb_12d_50l}" -ge 255 ]] && c_rgb_12d_50l=255
    [[ "${c_rgb_34d_50l}" -ge 255 ]] && c_rgb_34d_50l=255
    [[ "${c_rgb_56d_50l}" -ge 255 ]] && c_rgb_56d_50l=255
    printf -v c_hex_12d_50l '%x' "$c_rgb_12d_50l"
    printf -v c_hex_34d_50l '%x' "$c_rgb_34d_50l"
    printf -v c_hex_56d_50l '%x' "$c_rgb_56d_50l"
    [[ "${#c_hex_12d_50l}" -eq 1 ]] && c_hex_12d_50l="0${c_hex_12d_50l}"
    [[ "${#c_hex_34d_50l}" -eq 1 ]] && c_hex_34d_50l="0${c_hex_34d_50l}"
    [[ "${#c_hex_56d_50l}" -eq 1 ]] && c_hex_56d_50l="0${c_hex_56d_50l}"
    c_hex_50l="#${c_hex_12d_50l}${c_hex_34d_50l}${c_hex_56d_50l}"
    declare -g color"${i}"_lighter_50="$c_hex_50l"
    c_rgb_12d_60l="$(( c_rgb_12d + "$((c_rgb_12d * 3 / 5))" ))"
    c_rgb_34d_60l="$(( c_rgb_34d + "$((c_rgb_34d * 3 / 5))" ))"
    c_rgb_56d_60l="$(( c_rgb_56d + "$((c_rgb_56d * 3 / 5))" ))"
    [[ "${c_rgb_12d_60l}" -ge 255 ]] && c_rgb_12d_60l=255
    [[ "${c_rgb_34d_60l}" -ge 255 ]] && c_rgb_34d_60l=255
    [[ "${c_rgb_56d_60l}" -ge 255 ]] && c_rgb_56d_60l=255
    printf -v c_hex_12d_60l '%x' "$c_rgb_12d_60l"
    printf -v c_hex_34d_60l '%x' "$c_rgb_34d_60l"
    printf -v c_hex_56d_60l '%x' "$c_rgb_56d_60l"
    [[ "${#c_hex_12d_60l}" -eq 1 ]] && c_hex_12d_60l="0${c_hex_12d_60l}"
    [[ "${#c_hex_34d_60l}" -eq 1 ]] && c_hex_34d_60l="0${c_hex_34d_60l}"
    [[ "${#c_hex_56d_60l}" -eq 1 ]] && c_hex_56d_60l="0${c_hex_56d_60l}"
    c_hex_60l="#${c_hex_12d_60l}${c_hex_34d_60l}${c_hex_56d_60l}"
    declare -g color"${i}"_lighter_60="$c_hex_60l"
    c_rgb_12d_20d="$(( c_rgb_12d - "$((c_rgb_12d / 5))" ))"
    c_rgb_34d_20d="$(( c_rgb_34d - "$((c_rgb_34d / 5))" ))"
    c_rgb_56d_20d="$(( c_rgb_56d - "$((c_rgb_56d / 5))" ))"
    printf -v c_hex_12d_20d '%x' "$c_rgb_12d_20d"
    printf -v c_hex_34d_20d '%x' "$c_rgb_34d_20d"
    printf -v c_hex_56d_20d '%x' "$c_rgb_56d_20d"
    [[ "${#c_hex_12d_20d}" -eq 1 ]] && c_hex_12d_20d="0${c_hex_12d_20d}"
    [[ "${#c_hex_34d_20d}" -eq 1 ]] && c_hex_34d_20d="0${c_hex_34d_20d}"
    [[ "${#c_hex_56d_20d}" -eq 1 ]] && c_hex_56d_20d="0${c_hex_56d_20d}"
    c_hex_20d="#${c_hex_12d_20d}${c_hex_34d_20d}${c_hex_56d_20d}"
    declare -g color"${i}"_darker_20="$c_hex_20d"
    c_rgb_12d_30d="$(( c_rgb_12d - "$((c_rgb_12d * 3 / 10))" ))"
    c_rgb_34d_30d="$(( c_rgb_34d - "$((c_rgb_34d * 3 / 10))" ))"
    c_rgb_56d_30d="$(( c_rgb_56d - "$((c_rgb_56d * 3 / 10))" ))"
    printf -v c_hex_12d_30d '%x' "$c_rgb_12d_30d"
    printf -v c_hex_34d_30d '%x' "$c_rgb_34d_30d"
    printf -v c_hex_56d_30d '%x' "$c_rgb_56d_30d"
    [[ "${#c_hex_12d_30d}" -eq 1 ]] && c_hex_12d_30d="0${c_hex_12d_30d}"
    [[ "${#c_hex_34d_30d}" -eq 1 ]] && c_hex_34d_30d="0${c_hex_34d_30d}"
    [[ "${#c_hex_56d_30d}" -eq 1 ]] && c_hex_56d_30d="0${c_hex_56d_30d}"
    c_hex_30d="#${c_hex_12d_30d}${c_hex_34d_30d}${c_hex_56d_30d}"
    declare -g color"${i}"_darker_30="$c_hex_30d"
    c_rgb_12d_40d="$(( c_rgb_12d - "$((c_rgb_12d * 2 / 5))" ))"
    c_rgb_34d_40d="$(( c_rgb_34d - "$((c_rgb_34d * 2 / 5))" ))"
    c_rgb_56d_40d="$(( c_rgb_56d - "$((c_rgb_56d * 2 / 5))" ))"
    printf -v c_hex_12d_40d '%x' "$c_rgb_12d_40d"
    printf -v c_hex_34d_40d '%x' "$c_rgb_34d_40d"
    printf -v c_hex_56d_40d '%x' "$c_rgb_56d_40d"
    [[ "${#c_hex_12d_40d}" -eq 1 ]] && c_hex_12d_40d="0${c_hex_12d_40d}"
    [[ "${#c_hex_34d_40d}" -eq 1 ]] && c_hex_34d_40d="0${c_hex_34d_40d}"
    [[ "${#c_hex_56d_40d}" -eq 1 ]] && c_hex_56d_40d="0${c_hex_56d_40d}"
    c_hex_40d="#${c_hex_12d_40d}${c_hex_34d_40d}${c_hex_56d_40d}"
    declare -g color"${i}"_darker_40="$c_hex_40d"
    c_rgb_12d_50d="$(( c_rgb_12d - "$((c_rgb_12d / 2))" ))"
    c_rgb_34d_50d="$(( c_rgb_34d - "$((c_rgb_34d / 2))" ))"
    c_rgb_56d_50d="$(( c_rgb_56d - "$((c_rgb_56d / 2))" ))"
    printf -v c_hex_12d_50d '%x' "$c_rgb_12d_50d"
    printf -v c_hex_34d_50d '%x' "$c_rgb_34d_50d"
    printf -v c_hex_56d_50d '%x' "$c_rgb_56d_50d"
    [[ "${#c_hex_12d_50d}" -eq 1 ]] && c_hex_12d_50d="0${c_hex_12d_50d}"
    [[ "${#c_hex_34d_50d}" -eq 1 ]] && c_hex_34d_50d="0${c_hex_34d_50d}"
    [[ "${#c_hex_56d_50d}" -eq 1 ]] && c_hex_56d_50d="0${c_hex_56d_50d}"
    c_hex_50d="#${c_hex_12d_50d}${c_hex_34d_50d}${c_hex_56d_50d}"
    declare -g color"${i}"_darker_50="$c_hex_50d"
    c_rgb_12d_60d="$(( c_rgb_12d - "$((c_rgb_12d * 3 / 5))" ))"
    c_rgb_34d_60d="$(( c_rgb_34d - "$((c_rgb_34d * 3 / 5))" ))"
    c_rgb_56d_60d="$(( c_rgb_56d - "$((c_rgb_56d * 3 / 5))" ))"
    printf -v c_hex_12d_60d '%x' "$c_rgb_12d_60d"
    printf -v c_hex_34d_60d '%x' "$c_rgb_34d_60d"
    printf -v c_hex_56d_60d '%x' "$c_rgb_56d_60d"
    [[ "${#c_hex_12d_60d}" -eq 1 ]] && c_hex_12d_60d="0${c_hex_12d_60d}"
    [[ "${#c_hex_34d_60d}" -eq 1 ]] && c_hex_34d_60d="0${c_hex_34d_60d}"
    [[ "${#c_hex_56d_60d}" -eq 1 ]] && c_hex_56d_60d="0${c_hex_56d_60d}"
    c_hex_60d="#${c_hex_12d_60d}${c_hex_34d_60d}${c_hex_56d_60d}"
    declare -g color"${i}"_darker_60="$c_hex_60d"
  done
}

# Create colors.tdesktop-palette using the colors generated by create_colors()
# and the colors.wt-constants file.
create_palette() {
  cat <<EOF > "${DEST}/colors.tdesktop-theme"
color0: $color0;
color1: $color1;
color2: $color2;
color3: $color3;
color4: $color4;
color5: $color5;
color6: $color6;
color7: $color7;
color8: $color8;

// Lighter and darker variants of the colors.
colorLighter0_20: $color0_lighter_20;
colorLighter0_30: $color0_lighter_30;
colorLighter0_40: $color0_lighter_40;
colorLighter0_50: $color0_lighter_50;
colorLighter0_60: $color0_lighter_60;
colorDarker0_20: $color0_darker_20;
colorDarker0_30: $color0_darker_30;
colorDarker0_40: $color0_darker_40;
colorDarker0_50: $color0_darker_50;
colorDarker0_60: $color0_darker_60;
colorLighter1_20: $color1_lighter_20;
colorLighter1_30: $color1_lighter_30;
colorLighter1_40: $color1_lighter_40;
colorLighter1_50: $color1_lighter_50;
colorLighter1_60: $color1_lighter_60;
colorDarker1_20: $color1_darker_20;
colorDarker1_30: $color1_darker_30;
colorDarker1_40: $color1_darker_40;
colorDarker1_50: $color1_darker_50;
colorDarker1_60: $color1_darker_60;
colorLighter2_20: $color2_lighter_20;
colorLighter2_30: $color2_lighter_30;
colorLighter2_40: $color2_lighter_40;
colorLighter2_50: $color2_lighter_50;
colorLighter2_60: $color2_lighter_60;
colorDarker2_20: $color2_darker_20;
colorDarker2_30: $color2_darker_30;
colorDarker2_40: $color2_darker_40;
colorDarker2_50: $color2_darker_50;
colorDarker2_60: $color2_darker_60;
colorLighter3_20: $color3_lighter_20;
colorLighter3_30: $color3_lighter_30;
colorLighter3_40: $color3_lighter_40;
colorLighter3_50: $color3_lighter_50;
colorLighter3_60: $color3_lighter_60;
colorDarker3_20: $color3_darker_20;
colorDarker3_30: $color3_darker_30;
colorDarker3_40: $color3_darker_40;
colorDarker3_50: $color3_darker_50;
colorDarker3_60: $color3_darker_60;
colorLighter4_20: $color4_lighter_20;
colorLighter4_30: $color4_lighter_30;
colorLighter4_40: $color4_lighter_40;
colorLighter4_50: $color4_lighter_50;
colorLighter4_60: $color4_lighter_60;
colorDarker4_20: $color4_darker_20;
colorDarker4_30: $color4_darker_30;
colorDarker4_40: $color4_darker_40;
colorDarker4_50: $color4_darker_50;
colorDarker4_60: $color4_darker_60;
colorLighter5_20: $color5_lighter_20;
colorLighter5_30: $color5_lighter_30;
colorLighter5_40: $color5_lighter_40;
colorLighter5_50: $color5_lighter_50;
colorLighter5_60: $color5_lighter_60;
colorDarker5_20: $color5_darker_20;
colorDarker5_30: $color5_darker_30;
colorDarker5_40: $color5_darker_40;
colorDarker5_50: $color5_darker_50;
colorDarker5_60: $color5_darker_60;
colorLighter6_20: $color6_lighter_20;
colorLighter6_30: $color6_lighter_30;
colorLighter6_40: $color6_lighter_40;
colorLighter6_50: $color6_lighter_50;
colorLighter6_60: $color6_lighter_60;
colorDarker6_20: $color6_darker_20;
colorDarker6_30: $color6_darker_30;
colorDarker6_40: $color6_darker_40;
colorDarker6_50: $color6_darker_50;
colorDarker6_60: $color6_darker_60;
colorLighter7_20: $color7_lighter_20;
colorLighter7_30: $color7_lighter_30;
colorLighter7_40: $color7_lighter_40;
colorLighter7_50: $color7_lighter_50;
colorLighter7_60: $color7_lighter_60;
colorDarker7_20: $color7_darker_20;
colorDarker7_30: $color7_darker_30;
colorDarker7_40: $color7_darker_40;
colorDarker7_50: $color7_darker_50;
colorDarker7_60: $color7_darker_60;

// Alpha colors.
colorAlpha0_18: ${color0}18;
colorAlpha0_3c: ${color0}3c;
colorAlpha0_03: ${color0}03;
colorAlpha0_7f: ${color0}7f;
colorAlpha0_b0: ${color0}b0;
colorAlpha0_cc: ${color0}cc;
colorAlpha0_00: ${color0}00;
colorAlpha0_54: ${color0}54;
colorAlpha0_56: ${color0}56;
colorAlpha0_74: ${color0}74;
colorAlpha0_40: ${color0}40;
colorAlpha0_4c: ${color0}4c;
colorAlpha0_b2: ${color0}b2;
colorAlpha0_f2: ${color0}f2;
colorAlpha0_66: ${color0}66;
colorAlpha1_10: ${color1}10;
colorAlpha1_33: ${color1}33;
colorAlpha2_c8: ${color2}c8;
colorAlpha2_4c: ${color2}4c;
colorAlpha2_7f: ${color2}7f;
colorAlpha2_00: ${color2}00;
colorAlpha2_87: ${color2}87;
colorAlpha3_64: ${color3}64;
colorAlpha7_53: ${color7}53;
colorAlpha7_7a: ${color7}7a;
colorAlpha7_1a: ${color7}1a;
colorAlpha7_2c: ${color7}2c;
colorAlpha7_7f: ${color7}7f;
colorAlpha7_bc: ${color7}bc;
colorAlpha7_4c: ${color7}4c;
colorAlpha7_6b: ${color7}6b;
colorAlpha7_14: ${color7}14;
EOF
	mkdir -p "$DEST"
	cd "$DEST"
  const="$(<"colors.wt-constants")"
  printf '%s' "$const" >> "${DEST}/colors.tdesktop-theme"
  convert -size 256x256 "xc:$color0" tiled.jpg;
  zip -q base16.tdesktop-theme colors.tdesktop-theme tiled.jpg
}

main() {
  create_colors && create_palette && printf '%b\n' "\\e[1;31m::\\e[0m \\e[1;37mPalette generated succesfully.\\e[0m"
}

main
