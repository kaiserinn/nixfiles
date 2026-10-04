import Quickshell
import Quickshell.WindowManager
import QtQuick

// Numbered workspace indicator in the style of the reference:
// plain numbers "1 2 3 ...", active white/bold, inactive dim, urgent red.
Row {
  id: root

  required property var screen

  spacing: 14

  Repeater {
    model: ScriptModel {
      values: {
        const proj = WindowManager.screenProjection(root.screen);
        if (!proj)
          return [];
        // Niri exposes workspaces via ext-workspace-v1; keep displayable ones
        // and sort by first coordinate so numbering is stable.
        return proj.windowsets.filter(w => w.shouldDisplay).sort((a, b) => {
          const ac = (a.coordinates && a.coordinates.length > 0) ? a.coordinates[0] : 9999;
          const bc = (b.coordinates && b.coordinates.length > 0) ? b.coordinates[0] : 9999;
          if (ac !== bc)
            return ac - bc;
          const an = a.name || a.id || "";
          const bn = b.name || b.id || "";
          return an.localeCompare(bn);
        });
      }
    }

    delegate: Text {
      required property Windowset modelData
      required property int index

      text: modelData.name || modelData.id || (index + 1)
      color: {
        if (modelData.urgent)
          return "#f38ba8";
        return modelData.active ? Theme.text : Theme.textMuted;
      }
      font.pixelSize: 13
      font.bold: modelData.active
      font.family: "monospace"

      MouseArea {
        anchors.fill: parent
        enabled: parent.modelData.canActivate
        cursorShape: Qt.PointingHandCursor
        onClicked: parent.modelData.activate()
      }
    }
  }
}
