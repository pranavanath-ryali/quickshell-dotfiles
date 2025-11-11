pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    property int capacity

    Process {
        id: proc
        command: ['cat', '/sys/class/power_supply/BAT0/capacity']
        running: true

        stdout: StdioCollector {
            onStreamFinished: capacity = parseInt(this.text)
        }
    }

    Timer {
        interval: 30 * 1000
        running: true
        repeat: true

        onTriggered: proc.running = true
    }
}
