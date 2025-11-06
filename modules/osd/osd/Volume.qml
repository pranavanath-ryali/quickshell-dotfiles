import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets

import qs.config
import qs.services

Scope {
    id: root

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    Connections {
        target: Pipewire.defaultAudioSink?.audio

        function onVolumeChanged() {
            root.shouldShowOsd = true;
            hideTimer.restart();
        }

        function onMutedChanged() {
            root.shouldShowOsd = true;
            hideTimer.restart();
        }
    }
    property bool shouldShowOsd: false

    Timer {
        id: hideTimer
        interval: 1000
        onTriggered: root.shouldShowOsd = false
    }

    LazyLoader {
        active: root.shouldShowOsd

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

                            // text: {
                            //     if (Pipewire.defaultAudioSink?.audio.muted) {
                            //         return '';
                            //     } else if (Pipewire.defaultAudioSink?.audio.volume * 100 <= 25) {
                            //         return '';
                            //     } else if (Pipewire.defaultAudioSink?.audio.volume * 100 <= 50) {
                            //         return '';
                            //     } else {
                            //         return '';
                            //     }
                            // }

                            text: VolumeService.icon

                            state: Pipewire.defaultAudioSink?.audio.muted ? "MUTED" : "NEUTRAL"
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

                            implicitWidth: parent.width * ((Pipewire.defaultAudioSink?.audio.volume > 1 ? 1.0 : Pipewire.defaultAudioSink?.audio.volume) ?? 0)
                            radius: parent.radius

                            state: Pipewire.defaultAudioSink?.audio.volume > 1 ? "RED" : "NEUTRAL"
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
