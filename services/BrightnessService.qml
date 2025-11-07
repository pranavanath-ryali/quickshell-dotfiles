pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    FileView {
        id: maxBrightnessFile
        path: "/sys/class/backlight/intel_backlight/max_brightness"
    }

    FileView {
        id: brightnessFile
        path: "/sys/class/backlight/intel_backlight/brightness"

        onLoaded: brightness = parseInt(this.text())

        watchChanges: true
        onFileChanged: {
            brightness = parseInt(this.text());
            root.shouldShowOsd = true;
            hideTimer.restart();
            this.reload();
        }
    }

    Timer {
        id: hideTimer
        interval: 1000
        onTriggered: root.shouldShowOsd = false
    }

    property bool shouldShowOsd: false
    property int maxBrightness: parseInt(maxBrightnessFile.text())
    property int brightness: 0
    property int percentage: (brightness / maxBrightness) * 100
}
