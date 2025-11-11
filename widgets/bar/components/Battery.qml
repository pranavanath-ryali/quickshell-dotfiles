import QtQuick
import Quickshell
import Quickshell.Io

import qs.config
import qs.services

Row {
    anchors.verticalCenter: parent.verticalCenter

    Text {
        id: battery
        color: Colors.text

        font.weight: Fonts.regularWeight
        font.pixelSize: Fonts.regularSize

        text: `${BatteryService.capacity}%`
    }
}
