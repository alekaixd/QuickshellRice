import Quickshell
import QtQuick
import QtQuick.Layouts

// this button will create the music widget

Rectangle {
    id: musicRect
    Layout.alignment: Qt.AlignHCenter
    color: Theme.nord3
    width: 50
    height: 50
    radius: 8

    property Component widget: Qt.createComponent("MusicWidget.qml")
    property QtObject musicObject: null

    function toggleMusicWidget() {
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
        text: "music"
    }
    MouseArea {

        anchors.fill: parent

        onClicked: {
            musicText.text = "hi";
            musicRect.toggleMusicWidget();
        }
    }
}
