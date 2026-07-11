import Quickshell
import QtQuick
import QtQuick.Layouts

PanelWindow {
    implicitWidth: 400
    implicitHeight: 300
    anchors.left: true
    anchors.bottom: true
    color: "transparent"
    margins.left: 10
    margins.bottom: 10

    Rectangle {
        width: 400
        height: 300
        color: Theme.nord0
        radius: 10
        border.color: Theme.nord3
        border.width: 3
        opacity: 0.8
    }
}
