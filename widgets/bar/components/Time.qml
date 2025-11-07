import Quickshell
import Quickshell.Io
import QtQuick

import qs.config
import qs.services

Item {
    id: barClock
    visible: true

    // anchors.right: bar.anchors.right

    implicitWidth: barTimeText.width
    implicitHeight: parent.height

    Row {
        anchors.fill: parent.fill
        anchors.verticalCenter: parent.verticalCenter

        spacing: Fonts.regularSize

        Text {
            id: barTimeText
            anchors.verticalCenter: parent.verticalCenter

            text: TimeDateService.hour + ":" + TimeDateService.min

            color: Colors.text

            font.weight: Fonts.boldWeight
            font.pixelSize: Fonts.boldSize
        }

        Text {
            id: barDateText
            anchors.verticalCenter: parent.verticalCenter

            text: `${TimeDateService.day} ${TimeDateService.longMonth} ${TimeDateService.year}`

            color: Colors.text

            font.weight: Fonts.regularWeight
            font.pixelSize: Fonts.regularFontSize
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onHoveredChanged: {
            if (this.containsMouse) {
                barClock.state = "HOVER";
            } else {
                barClock.state = "NEUTRAL";
            }
        }
        onClicked: {
            bar.showCalendar = !bar.showCalendar;
        }
    }

    state: "NEUTRAL"
    states: [
        State {
            name: "NEUTRAL"
            PropertyChanges {
                target: barClock
                width: barTimeText.width
            }
            PropertyChanges {
                target: barDateText
                opacity: 0.0
            }
        },
        State {
            name: "HOVER"
            PropertyChanges {
                target: barClock
                width: barTimeText.width + Fonts.regularSize + barDateText.width
            }
            PropertyChanges {
                target: barDateText
                opacity: 1.0
            }
        }
    ]
    transitions: [
        Transition {
            from: "*"
            to: "NEUTRAL"
            SequentialAnimation {
                NumberAnimation {
                    target: barDateText
                    properties: "opacity"
                    duration: Decorations.animationSpeed0 * 2
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    target: barClock
                    properties: "width"
                    duration: Decorations.animationSpeed0
                    easing.type: Easing.InOutQuad
                }
            }
        },
        Transition {
            from: "*"
            to: "HOVER"
            SequentialAnimation {
                NumberAnimation {
                    target: barClock
                    properties: "width"
                    duration: Decorations.animationSpeed0
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    target: barDateText
                    properties: "opacity"
                    duration: Decorations.animationSpeed0 * 2
                    easing.type: Easing.InOutQuad
                }
            }
        }
    ]
}
