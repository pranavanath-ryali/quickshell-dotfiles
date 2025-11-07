pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire
import QtQuick

Singleton {
    id: root

    property bool shouldShowOsd: false

    property int volume: 0
    property bool muted: false
    property string icon: ""

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    function updateValues() {
        root.volume = Pipewire.defaultAudioSink?.audio.volume * 100;
        root.muted = Pipewire.defaultAudioSink?.audio.muted;

        if (root.muted) {
            root.icon = "";
        } else if (root.volume <= 25) {
            root.icon = "";
        } else if (root.volume <= 50) {
            root.icon = "";
        } else {
            root.icon = "";
        }
    }

    Connections {
        target: Pipewire.defaultAudioSink?.audio

        function onVolumeChanged() {
            root.shouldShowOsd = true;
            hideTimer.restart();
            updateValues();
        }

        function onMutedChanged() {
            root.shouldShowOsd = true;
            hideTimer.restart();
            updateValues();
        }
    }

    Timer {
        id: hideTimer
        interval: 1000
        onTriggered: root.shouldShowOsd = false
    }
}
