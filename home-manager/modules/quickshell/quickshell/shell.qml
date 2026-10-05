import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

Scope {
  id: root

  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }

  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink]
  }

  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: bar
      required property var modelData
      screen: modelData

      anchors {
        top: true
        left: true
        right: true
      }

      implicitHeight: Settings.barHeight
      color: Colors.background

      RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        spacing: 10

        NiriWorkspace {
          Layout.alignment: Qt.AlignVCenter
          screen: bar.modelData
        }

        Item {
          Layout.fillWidth: true
        }

        DateTime {
          clockDate: clock.date
        }

        Item {
          Layout.fillWidth: true
        }

        Row {
          Layout.alignment: Qt.AlignVCenter
          spacing: 14

          VolumeBar {}

          Text {
            anchors.verticalCenter: parent.verticalCenter
            readonly property var dev: UPower.displayDevice
            text: {
              if (!dev || !dev.ready)
                return "";
              const pct = Math.round(dev.percentage * 100) + "%";
              if (dev.state === UPowerDeviceState.Charging)
                return pct + " +";
              if (dev.state === UPowerDeviceState.FullyCharged)
                return pct + " full";
              return pct;
            }
            visible: text !== ""
            color: "#8a8a8a"
            font.pixelSize: 12
            font.family: "monospace"
          }
        }
      }
    }
  }
}
