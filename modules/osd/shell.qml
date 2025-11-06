import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets

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

            implicitWidth: 300
            implicitHeight: 50

            color: "transparent"

            mask: Region {}

            Rectangle {
                anchors.fill: parent

                color: "#1e1e2e"

                radius: 6
                border.color: "#ff11111b"
                border.width: 2

                RowLayout {
                    anchors {
                        fill: parent
                        leftMargin: 20
                        rightMargin: 20
                    }

                    spacing: 18

                    Rectangle {
                        width: 24

                        Text {
                            id: icontext
                            anchors.verticalCenter: parent.verticalCenter

                            text: {
                                if (Pipewire.defaultAudioSink?.audio.muted) {
                                    return '';
                                } else if (Pipewire.defaultAudioSink?.audio.volume * 100 <= 25) {
                                    return '';
                                } else if (Pipewire.defaultAudioSink?.audio.volume * 100 <= 50) {
                                    return '';
                                } else {
                                    return '';
                                }
                            }

                            color: '#ffcdd6f4'
                            font.pixelSize: 20

                            state: Pipewire.defaultAudioSink?.audio.muted ? "MUTED" : "NEUTRAL"
                            states: [
                                State {
                                    name: "MUTED"
                                    PropertyChanges {
                                        target: icontext
                                        color: "#ff585b70"
                                    }
                                },
                                State {
                                    name: "NEUTRAL"
                                    PropertyChanges {
                                        target: icontext
                                        color: "#ffcdd6f4"
                                    }
                                }
                            ]
                            transitions: [
                                Transition {
                                    from: "*"
                                    to: "MUTED"
                                    ColorAnimation {
                                        target: icontext
                                        duration: 50
                                    }
                                },
                                Transition {
                                    from: "*"
                                    to: "NEUTRAL"
                                    ColorAnimation {
                                        target: icontext
                                        duration: 50
                                    }
                                }
                            ]
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true

                        implicitHeight: 8
                        radius: 20
                        color: "#aa6c7086"

                        Rectangle {
                            id: fillrect
                            anchors {
                                left: parent.left
                                top: parent.top
                                bottom: parent.bottom
                            }

                            color: '#ffcdd6f4'

                            implicitWidth: parent.width * (Pipewire.defaultAudioSink?.audio.volume ?? 0)
                            radius: parent.radius

                            state: Pipewire.defaultAudioSink?.audio.volume > 1 ? "RED" : "NEUTRAL"
                            states: [
                                State {
                                    name: "RED"
                                    PropertyChanges {
                                        target: fillrect
                                        color: "#fff2cdcd"
                                    }
                                },
                                State {
                                    name: "NEUTRAL"
                                    PropertyChanges {
                                        target: fillrect
                                        color: "#ffcdd6f4"
                                    }
                                }
                            ]
                            transitions: [
                                Transition {
                                    from: "*"
                                    to: "RED"
                                    ColorAnimation {
                                        target: fillrect
                                        duration: 200
                                    }
                                },
                                Transition {
                                    from: "*"
                                    to: "NEUTRAL"
                                    ColorAnimation {
                                        target: fillrect
                                        duration: 200
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
