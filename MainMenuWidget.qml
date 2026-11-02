import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower

PanelWindow {
    id: mainPanel
    implicitWidth: 400
    implicitHeight: 300
    anchors.left: true
    anchors.bottom: true
    color: "transparent"
    margins.left: 10
    margins.bottom: 10

    property string batteryFullIcon: Quickshell.shellDir + "/Assets/icons/battery-full-solid-full.svg"

    Rectangle {
        width: 400
        height: 300
        color: Theme.nord0
        radius: 10
        border.color: Theme.nord3
        border.width: 3
        opacity: 0.8

        ColumnLayout {
            Item {
                id: batteryIcon
                width: 40
                height: 40
                Image {
                    source: mainPanel.batteryFullIcon
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                    // visible: false
                }
            }

            Text {
                id: batteryText
                text: "power: " + UPower.displayDevice.percentage * 100 + "%"
            }
            Text {
                id: isCharging
                text: "not charging: " + UPower.onBattery
            }
        }
    }
}
