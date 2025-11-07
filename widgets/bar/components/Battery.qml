import QtQuick
import Quickshell
import Quickshell.Io

Row {
    anchors.verticalCenter: parent.verticalCenter

    Text {
        id: battery
        text: "0%"
        color: "#cdd6f4"

        font.weight: 600
        font.pixelSize: 16


        Process {
            id: proc

            command: ['cat', '/sys/class/power_supply/BAT0/capacity']
            running: true

            stdout: StdioCollector {
                onStreamFinished: battery.text = this.text
            }
        }

        Timer {
            interval: 5000
            running: true
            repeat: true

            onTriggered: proc.running = true
        }
    }

    Text {
        text: "%"

        color: battery.color
        font: battery.font
    }
}
