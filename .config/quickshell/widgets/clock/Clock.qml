import QtQuick
import Quickshell
import "root:/colors.js" as Colors

Text {
    text: Time.time
    font.family: "JetBrainsMono Nerd Font Mono"
    font.pointSize: 12
    font.weight: 600
    anchors.centerIn: parent
    color: Colors.primary
}
