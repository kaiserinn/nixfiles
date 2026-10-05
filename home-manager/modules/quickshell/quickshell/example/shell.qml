//@ pragma ShellId bar-demo
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

  // Binds default sink so VolumeBar's `sink.audio` stays valid.
  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink]
  }

  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: bar
      required property var modelData
      screen: modelData

      reloadableId: "bar-" + modelData.name

      anchors {
        top: true
        left: true
        right: true
      }
      exclusionMode: ExclusionMode.Normal
      exclusiveZone: 30
      implicitHeight: 30

      // Solid opaque like the reference (no alpha -> no transparent-surface bug).
      color: "#0a0a0a"

      RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        spacing: 10

        // Start: numbered workspaces "1 2 3 ...".
        Workspaces {
          Layout.alignment: Qt.AlignVCenter
          screen: bar.modelData
        }

        // Center spacer (reference shows media here; kept empty).
        Item {
          Layout.fillWidth: true
        }

        // End: volume slider + battery + clickable date.
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

          ClockLabel {
            anchors.verticalCenter: parent.verticalCenter
            barWindow: bar
            clockDate: clock.date
          }
        }
      }
    }
  }
}
