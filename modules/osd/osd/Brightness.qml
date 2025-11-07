import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets

import qs.config
import qs.services

Scope {
    id: root

    LazyLoader {
        active: BrightnessService.shouldShowOsd

        PanelWindow {
            anchors.bottom: true
            margins.bottom: screen.height / 5
            exclusiveZone: 0

            implicitWidth: Fonts.regularSize * 24
            implicitHeight: Fonts.regularSize * 4

            color: "transparent"

            mask: Region {}

            Rectangle {
                anchors.fill: parent

                color: Colors.base

                radius: Decorations.borderRadius
                border.color: Colors.border
                border.width: Decorations.borderWidth

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: Fonts.regularSize * 2
                    anchors.rightMargin: Fonts.regularSize * 2

                    spacing: Fonts.regularSize

                    Rectangle {
                        width: Fonts.regularSize * 2

                        Text {
                            id: icontext
                            anchors.verticalCenter: parent.verticalCenter

							text: '󰃠'

                            color: Colors.lightblue
                            font.pixelSize: Fonts.regularSize * 1.5
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true

                        implicitHeight: Fonts.regularSize / 2
                        radius: implicitHeight / 4
                        color: Colors.surface

                        Rectangle {
                            id: fillrect
                            anchors {
                                left: parent.left
                                top: parent.top
                                bottom: parent.bottom
                            }

                            color: Colors.text

                            implicitWidth: parent.width * (BrightnessService.percentage / 100)
                            radius: parent.radius
                        }
                    }
                }
            }
        }
    }
}
