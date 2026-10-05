import QtQuick
import QtQuick.Layouts

// Month grid calendar. Driven by `baseDate` (today) plus a view offset
// so month navigation never mutates the clock date.
ColumnLayout {
  id: root

  property date baseDate: new Date()
  property int monthOffset: 0

  readonly property date viewDate: {
    const d = new Date(root.baseDate);
    d.setDate(1);
    d.setMonth(d.getMonth() + root.monthOffset);
    return d;
  }
  readonly property int viewYear: viewDate.getFullYear()
  readonly property int viewMonth: viewDate.getMonth()

  // 42 Monday-first cells: { day, inMonth, today }.
  readonly property var cells: {
    const first = new Date(root.viewYear, root.viewMonth, 1);
    const lead = (first.getDay() + 6) % 7;
    const start = new Date(root.viewYear, root.viewMonth, 1 - lead);
    const todayStr = root.baseDate.toDateString();
    const out = [];
    for (let i = 0; i < 42; i++) {
      const d = new Date(start);
      d.setDate(start.getDate() + i);
      out.push({
        day: d.getDate(),
        inMonth: d.getMonth() === root.viewMonth,
        today: d.toDateString() === todayStr
      });
    }
    return out;
  }

  function shiftMonth(delta) {
    root.monthOffset += delta;
  }

  function goToday() {
    root.monthOffset = 0;
  }

  spacing: 8

  // Header: < Month yyyy > + Today reset.
  RowLayout {
    Layout.fillWidth: true

    Text {
      text: "<"
      color: "#c94a5a"
      font.pixelSize: 15
      font.bold: true
      MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: root.shiftMonth(-1)
      }
    }

    Text {
      Layout.fillWidth: true
      horizontalAlignment: Text.AlignHCenter
      text: Qt.formatDateTime(root.viewDate, "MMMM yyyy")
      color: "#e6e6e6"
      font.pixelSize: 15
      font.bold: true
    }

    Text {
      text: "Today"
      color: root.monthOffset === 0 ? "#6c7086" : "#c94a5a"
      font.pixelSize: 12
      MouseArea {
        anchors.fill: parent
        enabled: root.monthOffset !== 0
        cursorShape: Qt.PointingHandCursor
        onClicked: root.goToday()
      }
    }

    Text {
      text: ">"
      color: "#c94a5a"
      font.pixelSize: 15
      font.bold: true
      MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: root.shiftMonth(1)
      }
    }
  }

  Rectangle {
    Layout.fillWidth: true
    implicitHeight: 1
    color: "#3a3a3a"
  }

  // Weekday header.
  Row {
    Layout.fillWidth: true
    Repeater {
      model: ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"]
      Text {
        required property var modelData
        required property int index
        width: parent.width / 7
        horizontalAlignment: Text.AlignHCenter
        text: modelData
        color: index >= 5 ? "#c94a5a" : "#8a8a8a"
        font.pixelSize: 11
        font.bold: true
        font.family: "monospace"
      }
    }
  }

  // Day grid.
  Grid {
    Layout.fillWidth: true
    columns: 7
    rowSpacing: 2
    columnSpacing: 0

    Repeater {
      model: root.cells
      Item {
        required property var modelData
        width: parent.width / 7
        height: 28

        Rectangle {
          anchors.centerIn: parent
          width: 24
          height: 24
          radius: 4
          color: parent.modelData.today ? "#c94a5a" : "transparent"
        }

        Text {
          anchors.centerIn: parent
          text: parent.modelData.day
          color: {
            if (parent.modelData.today)
              return "#ffffff";
            return parent.modelData.inMonth ? "#e6e6e6" : "#5a5a5a";
          }
          font.pixelSize: 12
          font.bold: parent.modelData.today
          font.family: "monospace"
        }
      }
    }
  }
}
