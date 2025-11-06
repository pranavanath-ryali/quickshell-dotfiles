import Quickshell
import Quickshell.Io
import QtQuick

import qs.config

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

        font.weight: Fonts.boldWeight
        font.pixelSize: Fonts.boldSize

        Process {
            id: dataProc

            command: ['date', '+%H:%M']
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
