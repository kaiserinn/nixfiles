import Quickshell
import Quickshell.WindowManager
import QtQuick

Row {
    id: root
    required property var screen
    spacing: 15

    Repeater {
        model: ScriptModel {
            values: {
                const proj = WindowManager.screenProjection(root.screen);
                if (!proj)
                    return [];
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
                if (modelData.urgent) return Colors.danger;
                return modelData.active ? Colors.text : Colors.textMuted;
            }
            font.pixelSize: Settings.fontSize
            font.family: Settings.fontFamily
            font.bold: modelData.active

            MouseArea {
                anchors.fill: parent
                enabled: parent.modelData.canActivate
                cursorShape: Qt.PointingHandCursor
                onClicked: parent.modelData.activate()
            }
        }
    }
}
