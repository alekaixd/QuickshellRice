pragma Singleton
import QtQuick

QtObject {
    readonly property color nord0: "#2e3440"
    readonly property color nord1: "#3b4252"
    readonly property color nord2: "#434c5e"
    readonly property color nord3: "#4c566a"
    readonly property color nord4: "#d8dee9"
    readonly property color nord5: "#e5e9f0"
    readonly property color nord6: "#eceff4"
    readonly property color nord7: "#8fbcbb"
    readonly property color nord8: "#88c0d0"
    readonly property color nord9: "#81a1c1"
    readonly property color nord10: "#5e81ac"
    readonly property color nord11: "#bf616a"
    readonly property color nord12: "#d08770"
    readonly property color nord13: "#ebcb8b"
    readonly property color nord14: "#a3be8c"
    readonly property color nord15: "#b48ead"

    property list<color> night: ["#2e3440", "#3b4252", "#434c5e", "#4c566a"]

    property list<color> snow: ["#eceff4", "#e5e9f0", "#d8dee9"]
    property list<color> frost: ["#8fbcbb", "#88c0d0", "#81a1c1", "#5e81ac"]

    property list<color> aurora: ["#bf616a", "#d08770", "#ebcb8b", "#a3be8c", "#b48ead"]
    readonly property string fontFamily: "JetBrainsMono Nerd Font"
    readonly property int fontSize: 16
}
