import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Wayland

ShellRoot {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData
            color: Theme.nord0

            anchors {
                top: true
                left: true
                bottom: true
            }
            implicitWidth: 70

            ColumnLayout {
                anchors.fill: parent
                anchors.bottomMargin: 10
                anchors.topMargin: 10
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
        }
    }
}
