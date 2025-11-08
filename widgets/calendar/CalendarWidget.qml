import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.services
import qs.config

import "../../modules"

PanelWindow {
    id: root

    implicitWidth: 300
    implicitHeight: 400

    anchors.top: true
    anchors.right: true

    color: "transparent"

    SectionRectangle {
        anchors.fill: parent

        color: Colors.base
        border.color: Colors.lightblue

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: Fonts.regularSize

            SectionRectangle {
                Layout.fillWidth: true
                implicitHeight: 100
            }

            SectionRectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true

                ColumnLayout {
                    anchors.fill: parent

                    Rectangle {
                        Layout.alignment: Qt.AlignTop
                        Layout.fillWidth: true
                        height: Fonts.boldSize * 3

                        color: "transparent"
                        Text {
                            anchors.fill: parent

                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter

                            color: Colors.blue

                            font.weight: Fonts.boldWeight
                            font.pixelSize: Fonts.boldSize

                            text: `${TimeDateService.day} ${TimeDateService.longMonth} ${TimeDateService.year}`
                        }
                    }

                    SectionRectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.alignment: Qt.AlignTop

                        color: "transparent"
                        
                        Calendar {}
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
