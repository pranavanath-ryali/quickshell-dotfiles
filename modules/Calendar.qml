import QtQuick
import QtQuick.Layouts

import qs.config

GridLayout {
    id: gridlayout

    anchors.fill: parent
    columns: 7
    rows: 6

    anchors.margins: Fonts.regularSize

    Repeater {
        model: ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"]

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "transparent"

            Text {
                anchors.fill: parent

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                font.pixelSize: Fonts.boldSize
                font.weight: Fonts.boldWeight

                color: Colors.lightblue

                text: modelData
            }
        }
    }

    Repeater {
        model: 35

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true

            radius: Decorations.borderRadius

            color: "transparent"

            Rectangle {
                anchors.centerIn: parent

                width: Fonts.boldSize * 2
                height: Fonts.boldSize * 2

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

                color: (isCurrentDay && isValidDay) ? Colors.lightred : "transparent"
                radius: Decorations.borderRadius

                Text {
                    anchors.fill: parent

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    font.pixelSize: Fonts.boldSize
                    font.weight: Fonts.boldWeight

                    text: parent.isValidDay ? parent.dayNumber : ""

                    color: (parent.isCurrentDay && parent.isValidDay) ? Colors.base : (parent.isValidDay) ? Colors.text : "transparent"
                }
            }
        }
    }
}
