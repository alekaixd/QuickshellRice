import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

ColumnLayout {
    id: wsColumn
    Layout.alignment: Qt.AlignHCenter

    property var monitor: Hyprland.monitorFor(screen)
    Repeater {
        model: Hyprland.workspaces

        Rectangle {
            id: wsButton

            property int spacesPerMonitor: 5
            property int monitorIndex: wsColumn.monitor.id

            property int minWs: (monitorIndex * spacesPerMonitor)
            property int maxWs: ((monitorIndex + 1) * spacesPerMonitor) - 1
            required property int index

            visible: index >= minWs && index <= maxWs

            property var workspace: Hyprland.workspaces.values.find(w => w.id === index + 1)
            property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

            implicitWidth: 32
            implicitHeight: 32
            radius: 8
            border.width: 2
            border.color: Theme.nord6

            color: hover.hovered ? Theme.nord4 : isActive ? Theme.nord6 : (workspace ? Theme.aurora[index % spacesPerMonitor] : "transparent")

            Behavior on color {
                ColorAnimation {
                    duration: 150
                }
            }

            /*Text {
                id: label
                //text: (wsButton.index % wsButton.spacesPerMonitor) + 1
                text: hover.hovered ? "hi" : ""
                color: Theme.nord0
                font.pixelSize: 24
                font.family: Theme.fontFamily
                font.weight: 400
                anchors.centerIn: parent
            }*/
            MouseArea {
                HoverHandler {
                    id: hover
                    cursorShape: Qt.PointingHandCursor
                }
                anchors.fill: parent
                onClicked: Hyprland.dispatch("hl.dsp.focus({ workspace = " + (parent.index + 1) + " })")
            }
        }
    }
}
