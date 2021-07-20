# Messaging apps workspace
i3 workspace $3
$HOME/.config/i3-layout-manager/layout_manager.sh $HOME/.config/i3-layout-manager/layouts/layout-MESSAGING.json
i3 exec discord
i3 exec telegram-desktop

## Startup terminals
i3 workspace $2
$HOME/.config/i3-layout-manager/layout_manager.sh $HOME/.config/i3-layout-manager/layouts/layout-TERMINALS.json
#It receives the default terminal as an argument
i3 exec $1
i3 exec $1 
i3 exec $1
