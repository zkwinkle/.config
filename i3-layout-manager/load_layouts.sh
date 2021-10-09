# Messaging apps workspace
i3 workspace $3
$HOME/.config/i3-layout-manager/layout_manager.sh $HOME/.config/i3-layout-manager/layouts/layout-MESSAGING.json

## Startup terminals ( go to terminal workspace )
i3 workspace $2
#$HOME/.config/i3-layout-manager/layout_manager.sh $HOME/.config/i3-layout-manager/layouts/layout-TERMINALS.json
# ^Enable this line to load the layout called TERMINALS

#It receives the default terminal as an argument
i3 exec $1
