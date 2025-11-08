import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

import qs.config
import qs.services

PanelWindow {
    anchors.top: true
    anchors.right: true

    focusable: true

    implicitWidth: calendarGrid.width + Fonts.regularSize * 3
    implicitHeight: 500

    color: "transparent"

    Item {
        width: calendarGrid.width + Fonts.regularSize * 2
        anchors.fill: parent

        anchors.rightMargin: Decorations.barPositionX
        anchors.topMargin: Decorations.barPositionY

        Rectangle {
            antialiasing: true

            anchors.fill: parent

            color: Colors.base
            radius: Decorations.borderRadius
            border.width: Decorations.borderWidth
            border.color: Colors.lightblue

            ColumnLayout {
                width: calendarGrid.width
                height: parent.height

                anchors.fill: parent
                anchors.margins: Fonts.regularSize
                anchors.rightMargin: Fonts.regularSize
                spacing: Fonts.regularSize

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter

                    width: parent.width
                    height: Fonts.boldSize * 2
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    text: `${TimeDateService.longMonth} ${TimeDateService.year}`

                    font.pixelSize: Fonts.boldSize
                    font.weight: Fonts.boldWeight

                    color: Colors.blue
                }

                Rectangle {
                    width: calendarGrid.width
                    Layout.fillHeight: true
                    color: "transparent"

                    Grid {
                        id: calendarGrid
                        Layout.fillHeight: true

                        anchors.horizontalCenter: parent.horizontalCenter

                        columns: 7
                        columnSpacing: Fonts.regularSize * 2
                        rowSpacing: Fonts.regularSize * 2

                        Repeater {
                            model: ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"]

                            Text {
                                text: modelData

                                font.pixelSize: Fonts.regularSize
                                font.weight: Fonts.boldWeight
                                color: Colors.text
                                width: Fonts.regularSize * 3
                                height: Fonts.regularSize * 2
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                        }

                        Repeater {
                            model: 35

                            Rectangle {
                                width: Fonts.regularSize * 3
                                height: Fonts.regularSize * 2

                                radius: 8

                                property var now: new Date()
                                property int currentDay: now.getDate()
                                property int currentMonth: now.getMonth()
                                property int currentYear: now.getFullYear()

                                // Calculate what day this cell represents
                                property var firstDay: new Date(currentYear, currentMonth, 1)
                                property int startOffset: firstDay.getDay() - 1  // 0 = Sunday
                                property int dayNumber: index - startOffset + 1
                                property var lastDay: new Date(currentYear, currentMonth + 1, 0)
                                property int daysInMonth: lastDay.getDate()
                                property bool isCurrentDay: dayNumber === currentDay
                                property bool isValidDay: dayNumber >= 1 && dayNumber <= daysInMonth

                                color: {
                                    if (isValidDay && isCurrentDay)
                                        return Colors.lightblue;
                                    return "transparent";
                                }

                                Text {
                                    anchors.centerIn: parent
                                    text: parent.isValidDay ? parent.dayNumber : ""
                                    font.pixelSize: Fonts.regularSize
                                    color: parent.isCurrentDay ? Colors.base : Colors.text
                                    font.weight: parent.isValidDay && parent.isCurrentDay ? Font.DemiBold : Font.Normal
                                }
                            }
                        }
                    }
                }
            }
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onHoveredChanged: {
                if (!this.containsMouse) {
                    bar.showCalendar = false;
                }
            }
        }
    }
}
