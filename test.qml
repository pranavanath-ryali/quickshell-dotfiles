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

    implicitWidth: 500
    implicitHeight: 500

    color: "transparent"

    Rectangle {
        anchors.fill: parent

        color: Colors.base
        radius: Decorations.borderRadius
        border.width: Decorations.borderWidth
        border.color: Colors.lightblue

        ColumnLayout {
            anchors.fill: parent
            // anchors.margins: Fonts.regularSize
            spacing: Fonts.regularSize

            Rectangle {
                id: timezones
                anchors.horizontalCenter: parent.horizontalCenter

                width: parent.width
                height: 100

                color: Colors.base1
                radius: Decorations.borderRadius
            }

            Rectangle {
                id: calendar

                width: parent.width

                // Layout.fillWidth: true
                Layout.fillHeight: true

                color: Colors.red
                radius: Decorations.borderRadius

                ColumnLayout {
                    width: parent.width
                    height: parent.height
                    spacing: Fonts.boldSize

                    y: Fonts.boldSize

                    Text {
                        id: calendarGridHeader
                        anchors.horizontalCenter: parent.horizontalCenter

                        width: parent.width
                        height: Fonts.boldSize * 4
                        horizontalAlignment: Text.AlignHCenter

                        text: `${TimeDateService.longMonth} ${TimeDateService.year}`

                        font.pixelSize: Fonts.boldSize
                        font.weight: Fonts.boldWeight

                        color: Colors.blue
                    }

                    Rectangle {
                        color: "transparent"

                        width: parent.width

                        anchors.horizontalCenter: parent.horizontalCenter

                        Layout.fillHeight: true

                        Grid {
                            id: calendarGrid
                            Layout.fillHeight: true

                            anchors.horizontalCenter: parent.horizontalCenter

                            columns: 7
                            rows: 6
                            // columnSpacing: Fonts.regularSize * 2
                            // columnSpacing: (this.width / 7) - (Fonts.regularSize * 3)
                            columnSpacing: (this.width / 7) + (Fonts.regularSize)
                            // rowSpacing: Fonts.regularSize * 1
                            // rowSpacing: (this.height / 6) - (Fonts.regularSize * 2)
                            rowSpacing: (this.height / 6) + (Fonts.regularSize)

                            Repeater {
                                model: ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"]

                                Text {
                                    text: modelData

                                    font.pixelSize: Fonts.regularSize
                                    font.weight: Fonts.boldWeight
                                    color: Colors.text
                                    width: Fonts.regularSize
                                    height: Fonts.regularSize
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                            }

                            Repeater {
                                model: 35

                                Rectangle {
                                    width: Fonts.regularSize
                                    height: Fonts.regularSize

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
