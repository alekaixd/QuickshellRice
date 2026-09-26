import Quickshell
import QtQuick
import QtQuick.Layouts

// this button will create the main menu widget

Rectangle {
    id: musicRect
    Layout.alignment: Qt.AlignHCenter
    color: "transparent"
    border.color: Theme.nord8
    radius: 8
    border.width: 2
    width: 55
    height: 70

    property Component widget: Qt.createComponent("CalendarWidget.qml")
    property QtObject musicObject: null

    function toggleCalendarWidget() {
        if (musicObject == null) {
            musicObject = widget.createObject();
        } else {
            musicObject.destroy();
        }
    }
    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
    Text {
        id: musicText
        anchors.centerIn: parent

        color: Theme.nord8
        font.pixelSize: 20
        font.family: Theme.fontFamily
        font.weight: 800
        text: Qt.formatDateTime(clock.date, "hh\nmm")
    }
    MouseArea {

        anchors.fill: parent

        onClicked: {
            musicRect.toggleCalendarWidget();
        }
    }
}
