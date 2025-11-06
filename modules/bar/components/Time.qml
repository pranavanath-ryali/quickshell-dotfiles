import Quickshell
import Quickshell.Io
import QtQuick

Item {
    id: workspacesClock
    visible: true

    implicitWidth: 65
    implicitHeight: parent.height

    Rectangle {
        anchors.fill: parent
        color: "transparent"
    }

    Text {
        id: clock
        anchors.centerIn: parent

        color: "#cdd6f4"

        font {
            weight: 800
            pixelSize: 16
        }

        Process {
            id: dataProc

            command: ['date', '+%H:%M']
            // command: ['expr', "$(date +%S) / 10"]
            // command: ["expr $(date '+%S') / 10"]
            // command: ['sh', '-c', 'expr $(date +%S) % 10']
            running: true

            stdout: StdioCollector {
                onStreamFinished: clock.text = this.text
            }
        }

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: dataProc.running = true
        }
    }
}
