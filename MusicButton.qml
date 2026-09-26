import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

// this button will create the music widget

Rectangle {
    id: musicRect
    property string spotifyIconPath: Quickshell.shellDir + "/Assets/icons/spotify-brands-solid-full.svg"
    property string playIconPath: Quickshell.shellDir + "/Assets/icons/circle-play-solid-full.svg"
    property string stopIconPath: Quickshell.shellDir + "/Assets/icons/circle-stop-solid-full.svg"

    Layout.alignment: Qt.AlignHCenter
    color: Theme.nord3
    width: 55
    height: buttonHovered ? 100 : 55
    radius: 8

    clip: true

    Image {
        id: albumArt
        anchors.fill: parent
        source: Player.artUrlPath
        fillMode: Image.PreserveAspectCrop
        visible: false
    }

    OpacityMask {
        anchors.fill: parent
        source: albumArt
        maskSource: Rectangle {
            width: musicRect.width
            height: musicRect.height
            radius: musicRect.radius
        }
    }

    property bool buttonHovered: playHover.hovered || hover.hovered

    Behavior on height {
        NumberAnimation {
            duration: 200
            easing.type: Easing.OutCubic
        }
    }

    property Component widget: Qt.createComponent("MusicWidget.qml")
    property QtObject musicObject: null

    function toggleMusicWidget() {
        if (musicObject == null) {
            musicObject = widget.createObject();
        } else {
            musicObject.destroy();
        }
    }

    MouseArea {
        anchors.fill: parent

        z: 0
        onClicked: {
            musicRect.toggleMusicWidget();
        }
        HoverHandler {
            id: hover
            cursorShape: Qt.PointingHandCursor
        }
    }
    Item { // Play Button
        width: 40
        height: 40
        Layout.fillWidth: true
        anchors.centerIn: parent
        Image {
            id: icon
            anchors.fill: parent
            anchors.centerIn: parent
            source: Player.musicPlaying ? stopIconPath : playIconPath
            fillMode: Image.PreserveAspectFit
            visible: false
        }
        MouseArea {
            anchors.fill: parent

            z: 1
            onClicked: {
                Player.playMusic();
            }
            HoverHandler {
                id: playHover
                cursorShape: Qt.PointingHandCursor
            }
        }

        // image and coloroverlay are both being sent to drop shadow so their visibility must be false

        ColorOverlay {
            id: pOverlay
            anchors.fill: icon
            source: icon
            color: Theme.nord6
            visible: false
        }
        DropShadow {
            anchors.fill: pOverlay
            horizontalOffset: 3
            verticalOffset: 3
            radius: 8.0
            color: Theme.nord0
            source: pOverlay
            opacity: buttonHovered ? 1.0 : 0.0
            Behavior on opacity {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.OutCubic
                }
            }
        }
    }
}
