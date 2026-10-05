import Quickshell
import QtQuick

Item {
    id: root
    required property date clockDate

    implicitWidth: label.implicitWidth
    implicitHeight: label.implicitHeight

    Text {
        id: label
        anchors.centerIn: parent
        text: Qt.formatDateTime(root.clockDate, "h:mm MMM d, yyyy")
        color: Colors.text
        font.pixelSize: Settings.fontSize
        font.family: Settings.fontFamily
    }
}
