import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets

import qs.config
import qs.services

Scope {
    id: root

    LazyLoader {
        active: VolumeService.shouldShowOsd

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
                            font.pixelSize: Fonts.regularSize * 1.5

                            text: VolumeService.icon

                            state: VolumeService.muted ? "MUTED" : "NEUTRAL"
                            states: [
                                State {
                                    name: "MUTED"
                                    PropertyChanges {
                                        target: icontext
                                        color: Colors.subtext
                                    }
                                },
                                State {
                                    name: "NEUTRAL"
                                    PropertyChanges {
                                        target: icontext
                                        color: Colors.lightblue
                                    }
                                }
                            ]
                            transitions: [
                                Transition {
                                    from: "*"
                                    to: "MUTED"
                                    ColorAnimation {
                                        target: icontext
                                        duration: Decorations.animation0Speed
                                    }
                                },
                                Transition {
                                    from: "*"
                                    to: "NEUTRAL"
                                    ColorAnimation {
                                        target: icontext
                                        duration: Decorations.animation0Speed
                                    }
                                }
                            ]
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

                            implicitWidth: parent.width * (VolumeService.volume > 100 ? 1 : VolumeService.volume / 100)
                            radius: parent.radius

                            state: VolumeService.volume > 100 ? "RED" : "NEUTRAL"
                            states: [
                                State {
                                    name: "RED"
                                    PropertyChanges {
                                        target: fillrect
                                        color: Colors.red
                                    }
                                },
                                State {
                                    name: "NEUTRAL"
                                    PropertyChanges {
                                        target: fillrect
                                        color: Colors.text
                                    }
                                }
                            ]
                            transitions: [
                                Transition {
                                    from: "*"
                                    to: "RED"
                                    ColorAnimation {
                                        target: fillrect
                                        duration: Decorations.animation0Speed
                                    }
                                },
                                Transition {
                                    from: "*"
                                    to: "NEUTRAL"
                                    ColorAnimation {
                                        target: fillrect
                                        duration: Decorations.animation0Speed
                                    }
                                }
                            ]
                        }
                    }
                }
            }
        }
    }
}
