import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Wayland

PanelWindow {
    id: draggable
    color: "transparent"
    mask: Region { //very very important as it makes it so that you can actually interact with things behind
        item: rect
    }

    WlrLayershell.layer: WlrLayer.Overlay
    exclusionMode: ExclusionMode.Ignore
    anchors {
        left: true
        top: true
    }

    implicitHeight: 1080
    implicitWidth: 1920

    Rectangle {
        id: rect
        width: 300
        height: 120
        x: 90
        y: 40
        color: "Transparent"
        MouseArea {
            anchors.fill: parent
            drag.target: rect
            drag.smoothed: true
            drag.minimumY: 0
            drag.minimumX: 0
            drag.maximumX: 1920 - rect.width
            drag.maximumY: 1080 - rect.height
        }
        Rectangle {
            anchors.fill: parent
            color: Theme.nord0
            opacity: 0.5
            radius: 10
            border.color: Theme.nord3
            border.width: 3
        }
        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 10
            anchors.rightMargin: 10

            Rectangle { // album cover
                width: 100
                height: 100
                color: Theme.nord3

                //maybe the song controls could go inside here
            }
            ColumnLayout {
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
                Layout.bottomMargin: 10
                Text {
                    color: Theme.nord8
                    font.pixelSize: 16
                    font.family: Theme.fontFamily
                    font.weight: 800
                    text: "Song name"
                }
                Text {
                    color: Theme.nord9
                    font.pixelSize: 14
                    font.family: Theme.fontFamily
                    font.weight: 400
                    text: "Artist Name"
                }
            }
            Item {
                Layout.fillWidth: true
            }
        }
    }
}
