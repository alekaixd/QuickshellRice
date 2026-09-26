import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Basic
import Quickshell.Wayland
import Qt5Compat.GraphicalEffects

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
    property bool buttonHovered: playHover.hovered || hover.hovered
    property string forwardIconPath: Quickshell.shellDir + "/Assets/icons/forward-solid-full.svg"
    property string backwardIconPath: Quickshell.shellDir + "/Assets/icons/backward-solid-full.svg"

    Rectangle {
        id: rect
        width: 300
        height: 120
        x: 95
        y: 25
        color: "transparent"
        property string title
        property string imgUrl
        MouseArea {
            anchors.fill: parent
            drag.target: rect
            drag.smoothed: true
            drag.minimumY: 0
            drag.minimumX: 0
            drag.maximumX: 1920 - rect.width
            drag.maximumY: 1080 - rect.height
        }
        Item {
          anchors.fill: parent
          Rectangle {
            id: background
            anchors.centerIn: parent
            width: parent.width / 1.5
            height: parent.height / 2
            radius: 10
            color: Theme.nord3
            visible: false 
          }
          RectangularShadow {
            anchors.fill: background
            radius: background.radius
            color: Theme.nord0
            opacity: 0.6
            blur: 100
            spread: 10
          }
        }
                ColumnLayout {
            anchors.fill: parent

            RowLayout {
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft | Qt.AlignRight
                Rectangle { // album cover
                    Layout.alignment: Qt.AlignTop
                    width: 100
                    height: 100
                    color: "transparent"

                    Image {
                        id: albumArt
                        anchors.fill: parent
                        source: Player.artUrlPath
                        fillMode: Image.PreserveAspectCrop
                    }
                    //maybe the song controls could go inside here
                    HoverHandler {
                        id: hover
                    }
                    RowLayout {
                        anchors.fill: parent
                        spacing: 0
                        Item { // previous song
                            Layout.leftMargin: 5
                            width: 20
                            height: 20
                            Layout.fillWidth: true
                            Image {
                                id: previous
                                anchors.fill: parent
                                anchors.centerIn: parent
                                source: draggable.backwardIconPath
                                fillMode: Image.PreserveAspectFit
                                visible: false
                            }
                            MouseArea {
                                anchors.fill: parent

                                z: 1
                                onClicked: {
                                    Player.lastSong();
                                }
                                HoverHandler {
                                    id: prevHover
                                    cursorShape: Qt.PointingHandCursor
                                }
                            }
                            ColorOverlay {
                                id: prOverlay
                                anchors.fill: previous
                                source: previous
                                color: Theme.nord6
                                visible: false
                            }
                            DropShadow {
                                anchors.fill: prOverlay
                                horizontalOffset: 2
                                verticalOffset: 2
                                radius: 8.0
                                color: Theme.nord0
                                source: prOverlay
                                opacity: buttonHovered ? 1.0 : 0.0
                                Behavior on opacity {
                                    NumberAnimation {
                                        duration: 200
                                        easing.type: Easing.OutCubic
                                    }
                                }
                            }
                        }

                        Item { // Play Button
                            width: 40
                            height: 40
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignVCenter
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
                        Item { // Next Song
                            width: 20
                            height: 20
                            Layout.rightMargin: 5
                            Layout.fillWidth: true
                            Image {
                                id: forward
                                anchors.fill: parent
                                anchors.centerIn: parent
                                source: draggable.forwardIconPath
                                fillMode: Image.PreserveAspectFit
                                visible: false
                            }
                            MouseArea {
                                anchors.fill: parent

                                z: 1
                                onClicked: {
                                    Player.nextSong();
                                }
                                HoverHandler {
                                    id: nextHover
                                    cursorShape: Qt.PointingHandCursor
                                }
                            }
                            ColorOverlay {
                                id: nOverlay
                                anchors.fill: forward
                                source: forward
                                color: Theme.nord6
                                visible: false
                            }
                            DropShadow {
                                anchors.fill: nOverlay
                                horizontalOffset: 2
                                verticalOffset: 2
                                radius: 8.0
                                color: Theme.nord0
                                source: nOverlay
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
                }
                ColumnLayout {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
                    Text {
                        Layout.fillWidth: true
                        color: Theme.nord8
                        font.pixelSize: 16
                        font.family: Theme.fontFamily
                        font.weight: 800
                        style: Text.Raised

                        text: Player.song.length > 30 ? Player.song.slice(0, 30) + "..." : Player.song

                        wrapMode: Text.WordWrap
                    }
                    Text {
                        id: artistText
                        Layout.fillWidth: true
                        color: Theme.nord9
                        font.pixelSize: 14
                        font.family: Theme.fontFamily
                        font.weight: 400
                        style: Text.Raised
                        text: Player.artist.length > 30 ? Player.artist.slice(0, 17) + "..." : Player.artist
                        wrapMode: Text.WordWrap
                    }
                }
                Item {
                    Layout.fillWidth: true
                }
            }

            Rectangle {
                Layout.alignment: Qt.AlignTop
                opacity: 1.0
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "transparent"

                Slider {
                    id: songPos

                    anchors.fill: parent
                    from: 0
                    value: Player.position
                    to: Player.songLength// song length
                    live: false //doesnt update the value when dragging
                    leftPadding: 0
                    rightPadding: 0
                    topPadding: 0

                    HoverHandler {
                        id: posHover
                        cursorShape: Qt.PointingHandCursor
                    }

                    onPressedChanged: {
                      if(!pressed) {
                        Player.updateSongPos(songPos.value)
                      }
                    }

                    background: Rectangle {
                        x: songPos.leftPadding
                        y: songPos.topPadding + songPos.availableHeight / 2 - height / 2
                        implicitWidth: 200
                        implicitHeight: 4
                        width: songPos.availableWidth
                        height: implicitHeight
                        gradient: Gradient {
                            orientation: Gradient.Horizontal
                            GradientStop {
                                position: 0.0
                                color: Theme.nord10
                            }
                            GradientStop {
                                position: 0.5
                                color: Theme.nord9
                            }
                            GradientStop {
                                position: 1.0
                                color: Theme.nord10
                            }
                        }
                        ShaderEffect {
                            anchors.fill: parent
                            fragmentShader: Quickshell.shellDir + "/Assets/noise.frag.qsb"
                        }
                        Rectangle {
                            width: songPos.visualPosition * parent.width
                            height: parent.height
                            gradient: Gradient {
                                orientation: Gradient.Horizontal
                                GradientStop {
                                    position: 0.0
                                    color: Theme.nord11
                                }
                                GradientStop {
                                    position: 0.5
                                    color: Theme.nord12
                                }
                                GradientStop {
                                    position: 1.0
                                    color: Theme.nord13
                                }
                            }
                            ShaderEffect {
                                anchors.fill: parent
                                fragmentShader: Quickshell.shellDir + "/Assets/noise.frag.qsb"
                            }
                        }
                    }

                    handle: Rectangle {
                        x: songPos.leftPadding + songPos.visualPosition * (songPos.availableWidth - width)
                        y: songPos.topPadding + songPos.availableHeight / 2 - height / 2
                        implicitWidth: 10
                        implicitHeight: 10
                        radius: 13
                        opacity: posHover.hovered ? 1.0 : 0.0
                        color: Theme.nord14
                    }
                }
            }
        }
    }
}
