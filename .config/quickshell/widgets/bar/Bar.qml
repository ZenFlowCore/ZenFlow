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
import "root:/widgets/styles"
import "root:/widgets/tools"
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
                left: true
                top: true
                bottom: true
            }

            color: "#90" + Colors.background.slice(1)
            implicitWidth: 50

            
            Column {
                id: column
                anchors.fill: parent
                spacing: 10

                // Arch
                Item {
                    id: archie
                    implicitHeight: parent.width
                    anchors.topMargin: margin
                    implicitWidth: parent.width
                    anchors.top: parent.top
                    anchors.bottom: clockie
                    Text {
                        text: ""
                        // rotation: 270
                        font.pointSize: 15
                        color: Colors.primary
                        anchors.centerIn: parent
                    }
                }
                        
                Item {
                    id: toolie
                    anchors {
                        top: archie.bottom

                    }

                       
                    Tools {}
                    implicitWidth: parent.width
                    implicitHeight: parent.width
                     
                }    

                // Clock
                Item {
                    id: clockie
                    anchors.centerIn: parent
                    Clock {}
                }
                // Workspace
                Item {
                    id: workies
                    anchors.bottom: loggie.top
                    anchors.top: clockie.bottom
                    anchors.right: parent.right
                    Workspace {}
                }
                // Test
                Item {

                    implicitWidth: parent.width
                    implicitHeight: parent.width
                    anchors.bottom: batterie.top
                    anchors.bottomMargin: margin

                    Test {}
                }  
                // Battery
                Item {
                    id: batterie
                    implicitHeight: parent.width
                    implicitWidth: parent.width
                    anchors.bottom: loggie.top
                    Battery {}
                }
                
                  

                Item {
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
