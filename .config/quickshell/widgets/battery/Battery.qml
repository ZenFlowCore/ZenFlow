// Battery.qml
import QtQuick
import QtQuick.Controls
import Quickshell.Widgets
import Quickshell
import "root:/icons/icons.js" as Icons
import QtQuick.Effects
Item {
    id: batterie
    width: parent.width
    implicitHeight: parent.implicitHeight
    property bool show: false
    IconImage {
        id: icon
        source: Quickshell.iconPath(updateIcon())
        implicitSize: 24
        anchors.centerIn: parent
    }

    function updateIcon() {
        const charging = SingBattery.isCharging;
        const percentage = SingBattery.percentage;

        if (charging) return Icons.batt_charging;
        if (percentage > 95) return Icons.batt_full;
        if (percentage >= 75) return Icons.batt_4;
        if (percentage >= 50) return Icons.batt_3;
        if (percentage >= 25) return Icons.batt_2;
        if (percentage >= 10) return Icons.batt_1;
        return Icons.batt_empty;
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onEntered: batterie.show = true
        onExited: batterie.show = false
    }

    PopUpBattery {
    }
}
