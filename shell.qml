import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Wayland
import Qt5Compat.GraphicalEffects

ShellRoot {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData
            color: "transparent"
            WlrLayershell.layer: WlrLayer.Bottom

            anchors {
                top: true
                left: true
                bottom: true
            }
            implicitWidth: 70

            Rectangle {
                id: gradient
                anchors.fill: parent

                gradient: Gradient {
                    GradientStop {
                        position: 0.0
                        color: Theme.nord3
                    }
                    GradientStop {
                        position: 1.0
                        color: Theme.nord0
                    }
                }
            }

            Image {
                id: overlay
                source: Quickshell.shellDir + "/Assets/overlay-effect-rotating.png"
                fillMode: Image.PreserveAspectCrop
                visible: false
            }

            ColorOverlay {
                anchors.fill: overlay
                source: overlay
                color: Theme.nord9
                opacity: 0.5
                transform: [
                    Rotation {
                        id: rotation
                        origin.x: overlay.width / 2
                        origin.y: overlay.height / 2
                        angle: 45
                    },
                    Translate {
                        x: -300
                    }
                ]
                NumberAnimation {
                    target: rotation
                    property: "angle"
                    from: 0
                    to: 360
                    duration: 500000
                    loops: Animation.Infinite
                    running: true
                }
            }

            ShaderEffect {
                anchors.fill: parent
                fragmentShader: Quickshell.shellDir + "/Assets/noise.frag.qsb"
            }
            RowLayout {
                anchors.fill: parent

                ColumnLayout {
                    Layout.fillWidth: parent
                    Layout.fillHeight: parent
                    Layout.bottomMargin: 5
                    Layout.topMargin: 5
                    Layout.leftMargin: 5
                    MusicButton {}
                    Item {
                        Layout.fillHeight: true
                    }
                    Workspaces {}
                    Item {
                        Layout.fillHeight: true
                    }
                    DateWidget {}
                    MainMenuButton {}
                }
                Rectangle {
                    opacity: 1
                    Layout.fillHeight: true
                    Layout.minimumWidth: 4
                    gradient: Gradient {
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
                }
            }
        }
    }
}
