import QtQuick
import Quickshell
import Quickshell.Io

import qs.config
import qs.services

Row {
    id: workspacesRow
    spacing: Fonts.regularSize

    Repeater {
        model: Workspaces.workspaces

        Rectangle {
            required property var modelData

            visible: modelData.id >= 0

            width: 3 * barRect.height / 4
            height: 3 * barRect.height / 4
            color: "transparent"

            MouseArea {
                anchors.fill: parent
                onClicked: Workspaces.dispatch(modelData.id)
            }

            Text {
                anchors.centerIn: parent
                font.pixelSize: Fonts.regularSize

                text: {
                    if (modelData.id === 1) {
                        return "I";
                    } else if (modelData.id === 2) {
                        return "II";
                    } else if (modelData.id === 3) {
                        return "III";
                    } else if (modelData.id === 4) {
                        return "IV";
                    } else if (modelData.id === 5) {
                        return "V";
                    } else if (modelData.id === 6) {
                        return "VI";
                    } else if (modelData.id === 7) {
                        return "VII";
                    }
                }

                color: {
                    if (modelData.toplevels.values.length > 0) {
                        return Colors.blue;
                    } else {
                        return Colors.subtext;
                    }
                }
            }
        }
    }
}
