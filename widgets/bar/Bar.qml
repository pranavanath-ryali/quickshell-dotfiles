import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

import qs.config

import "./components"
import "../calendar"

Scope {

    property bool showCalendar: false

    PanelWindow {
        id: panel

        anchors {
            left: true
            top: true
            right: true
        }
        aboveWindows: true

        implicitWidth: screen.width
        implicitHeight: Fonts.regularSize * 3.5

        color: "transparent"

        Item {
            width: panel.width
            height: panel.height

            Rectangle {
                id: bar

                x: Decorations.barPositionX
                y: Decorations.barPositionY

                width: parent.width - (Decorations.barPositionX * 2)
                height: parent.height - Decorations.barPositionY

                color: Colors.base

                radius: Decorations.borderRadius
                border.color: Colors.barBorder
                border.width: Decorations.borderWidth

                Row {
                    id: barLeft

                    layoutDirection: Qt.LeftToRight

                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: Fonts.regularSize

                    BarWorkspaces {}
                }

                Row {
                    id: barRight

                    layoutDirection: Qt.RightToLeft

                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: Fonts.regularSize

                    width: panel.width / 3
                    height: parent.height

                    spacing: Fonts.regularSize

                    Time {}
                    Battery {}
                }
            }
        }
    }

    // LazyLoader {
    //     id: calendarPopup
    //     active: bar.showCalendar
    //
    //     CalendarPopup {}
    // }
}
