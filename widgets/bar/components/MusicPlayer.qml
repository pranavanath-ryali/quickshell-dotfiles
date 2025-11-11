import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris
import QtQuick

Rectangle {
    width: 1000
    height: parent.height

    color: "black"

    Process {
        running: true
        command: ["python3", "scripts/mpd.py"]
        stdout: StdioCollector {
            onStreamFinished: player.text = this.text
        }
    }

    Text {
        id: player
        required property var modelData

        text: modelData.dbusName

        color: "white"
    }
}
