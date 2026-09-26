import Quickshell
import QtQuick
import QtQuick.Layouts

// this button will create the main menu widget

Rectangle {
    id: musicRect
    Layout.alignment: Qt.AlignHCenter
    color: Theme.nord3
    width: 55
    height: 55
    radius: 8

    property Component widget: Qt.createComponent("MainMenuWidget.qml")
    property QtObject musicObject: null

    function toggleMenuWidget() {
        if (musicObject == null) {
            musicObject = widget.createObject();
        } else {
            musicObject.destroy();
        }
    }
    Text {
        id: musicText
        anchors.centerIn: parent

        color: Theme.nord7
        font.pixelSize: Theme.fontSize
        font.family: Theme.fontFamily
        text: "menu"
    }
    MouseArea {

        anchors.fill: parent

        onClicked: {
            musicRect.toggleMenuWidget();
        }
    }
}
