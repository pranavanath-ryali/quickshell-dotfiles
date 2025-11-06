import Quickshell
import QtQuick

Scope {
    Loader {
        active: true
        source: "./osd/Volume.qml"
    }
    Loader {
        active: true
        source: "./osd/Brightness.qml"
    }
}
