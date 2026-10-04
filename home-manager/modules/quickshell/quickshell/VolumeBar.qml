import Quickshell.Services.Pipewire
import QtQuick

// Volume widget in the style of the reference:
// small icon + thin track with red fill. Click icon toggles mute,
// click/drag on the bar seeks, wheel adjusts by 5%.
Row {
  id: root

  spacing: 8

  readonly property var sink: Pipewire.defaultAudioSink
  readonly property bool sinkOk: sink != null && sink.audio != null
  readonly property real level: sinkOk ? sink.audio.volume : 0
  readonly property bool muted: sinkOk && sink.audio.muted

  // Icon: plain glyphs to avoid font dependency.
  Text {
    id: icon
    anchors.verticalCenter: parent.verticalCenter
    text: {
      if (!root.sinkOk)
        return "--";
      if (root.muted)
        return "M";
      if (root.level < 0.01)
        return "O";
      return "V";
    }
    color: root.muted ? "#6c7086" : "#e6e6e6"
    font.pixelSize: 13
    font.bold: true
    font.family: "monospace"

    MouseArea {
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor
      onClicked: {
        if (root.sink?.audio)
          root.sink.audio.muted = !root.sink.audio.muted;
      }
    }
  }

  // Thin slider bar: 70x2 track like the screenshot.
  Item {
    id: slider
    width: 70
    height: 16
    anchors.verticalCenter: parent.verticalCenter

    Rectangle {
      anchors.verticalCenter: parent.verticalCenter
      width: parent.width
      height: 2
      color: "#3a3a3a"
    }

    Rectangle {
      anchors.verticalCenter: parent.verticalCenter
      width: root.muted ? 0 : Math.round(parent.width * Math.max(0, Math.min(1, root.level)))
      height: 2
      color: root.muted ? "#6c7086" : "#c94a5a"
    }

    MouseArea {
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor

      function seek(mouse) {
        const s = root.sink;
        if (!s?.audio)
          return;
        const frac = Math.max(0, Math.min(1, mouse.x / slider.width));
        s.audio.volume = frac;
        if (s.audio.muted && frac > 0)
          s.audio.muted = false;
      }

      onPressed: mouse => seek(mouse)
      onPositionChanged: mouse => {
        if (pressed)
          seek(mouse);
      }
      onWheel: wheel => {
        const s = root.sink;
        if (!s?.audio)
          return;
        const step = wheel.angleDelta.y > 0 ? 0.05 : -0.05;
        s.audio.volume = Math.max(0, Math.min(1, s.audio.volume + step));
      }
    }
  }
}
