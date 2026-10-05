import Quickshell
import QtQuick

// Clickable date label (reference format "12:57 Jan 27, 2021").
// Click toggles a PopupWindow calendar anchored under the bar.
Item {
  id: root

  required property var barWindow
  property date clockDate: new Date()

  implicitWidth: label.implicitWidth
  implicitHeight: label.implicitHeight

  Text {
    id: label
    anchors.centerIn: parent
    text: Qt.formatDateTime(root.clockDate, "h:mm MMM d, yyyy")
    color: "#e6e6e6"
    font.pixelSize: 13
    font.family: "monospace"

    MouseArea {
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor
      onClicked: calendarPopup.visible = !calendarPopup.visible
    }
  }

  PopupWindow {
    id: calendarPopup
    anchor.window: root.barWindow
    anchor.rect.x: root.barWindow.width - implicitWidth - 8
    anchor.rect.y: root.barWindow.height + 4
    implicitWidth: 300
    implicitHeight: 340
    visible: false
    grabFocus: true
    color: "transparent"

    Rectangle {
      anchors.fill: parent
      radius: 8
      color: "#111111"
      border.width: 1
      border.color: "#3a3a3a"

      CalendarView {
        anchors.fill: parent
        anchors.margins: 14
        baseDate: root.clockDate
      }

      // Escape closes.
      Shortcut {
        sequence: "Escape"
        onActivated: calendarPopup.visible = false
      }
    }
  }
}
