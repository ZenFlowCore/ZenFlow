// Bar.qml
import Quickshell
import QtQuick
import QtQuick.Layouts
import "root:/widgets/battery"
import "root:/widgets/clock"
import "root:/widgets/audio"
import "root:/widgets/workspaces"
import "root:/widgets/logout"
import "root:/widgets/border"
import "root:/colors.js" as Colors
import "root:/widgets/test"
Scope {
    Variants {
        model: Quickshell.screens
        PanelWindow {
            id: bar
            property var modelData
            property real margin: 15
            property real base_margin: 20
            property bool isSoleBar: Quickshell.screens.length == 1
            screen: modelData

            anchors {
                right: true
                top: true
                bottom: true
            }

            color: "#90" + Colors.background.slice(1)
            implicitWidth: 5

            
            Column {
                id: column
                anchors.fill: parent
                spacing: 10

                

               
                
                // Test
                Item {

                    Rectangle {
                        color: "#fff"
                        width: parent.width
                        height: parent.height
                    }

                    implicitWidth: parent.width
                    implicitHeight: 100
                    anchors.bottom: batterie.top
                    anchors.bottomMargin: margin

                    Test {}
                }  
                // Battery
                Item {
                    id: batterie
                    implicitHeight: 100
                    implicitWidth: parent.width

                    anchors.bottom: loggie.top
                    Battery {}
                }
                
                  

                Item {

                    Rectangle {
                        implicitWidth: parent.width
                        implicitHeight: 20
                        color: "#fff"
                    }

                    id: loggie
                    implicitWidth: parent.width
                    implicitHeight: parent.width
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: margin

                    Logout {
                        id: wlogout
                    }
                    Text {
                        text: ""
                        anchors.centerIn: parent
                        color: Colors.primary
                        font.pointSize: 13
                    }

                    property bool show: false

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            loggie.show = true;
                            console.log("gud");
                        }
                    }
                }
                    
               }
        }
    }
}
