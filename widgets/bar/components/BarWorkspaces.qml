import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

Row {
    id: workspacesRow
    spacing: 6

    Repeater {
        model: Hyprland.workspaces

        Rectangle {
            required property var modelData

            visible: modelData.id >= 0
            width: 3 * bar.height / 4
            height: 3 * bar.height / 4
            radius: 4
            // color: modelData.active ? "red" : "black"
            color: "transparent"

            MouseArea {
                anchors.fill: parent
                onClicked: Hyprland.dispatch("workspace " + modelData.id)
            }

            Text {
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
                anchors.centerIn: parent

                // color: modelData.active ? "white" : "gray"
                color: {
                    if (modelData.active) {
                        return "white";
                    // } else if (occupied) {
                    //     return "gray";
                    } else {
                        return "gray";
                    }
                }

                font.family: "monospace"
                font.pixelSize: 12
            }
        }
    }
}
