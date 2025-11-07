import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

import qs.config

import "./components"

Scope {
    id: root

    PanelWindow {
        id: panel

        anchors {
            left: true
            top: true
            right: true
        }
        aboveWindows: true

        implicitWidth: screen.width
        implicitHeight: 40

        color: "transparent"

        Item {
            width: panel.width
            height: panel.height

            Rectangle {
                id: bar

                x: 6
                y: 6

                width: parent.width - 12
                height: parent.height - 4

                color: "#1e1e2e"
                radius: 6

                border.color: "#1e11111b"
                border.width: 2

                Row {
                    id: barLeft

                    layoutDirection: Qt.LeftToRight

                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 5

                    BarWorkspaces {}
                }

                Row {
                    id: barRight

                    layoutDirection: Qt.RightToLeft

                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: 5

                    width: panel.width / 3
                    height: parent.height

                    spacing: 10

                    Time {}
                    BinaryClock {}
                    Battery {}
                    // MusicPlayer {}
                }
                Rectangle {
                    anchors.fill: barRight
                    color: "transparent"
                }
            }

            MultiEffect {
                anchors.fill: bar
                source: bar

                shadowEnabled: false
                shadowOpacity: 1.0
                shadowColor: "#ff000000"
                shadowScale: 1.0
                shadowHorizontalOffset: 0
                shadowVerticalOffset: 0
            }
        }
    }
}
