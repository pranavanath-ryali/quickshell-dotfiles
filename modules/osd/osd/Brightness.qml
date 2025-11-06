import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets

Scope {
    id: root

    FileView {
        id: maxBrightnessFile
        path: "/sys/class/backlight/intel_backlight/max_brightness"
    }

    FileView {
        id: brightnessFile
        path: "/sys/class/backlight/intel_backlight/brightness"

        onLoaded: brightness = parseInt(this.text())

        watchChanges: true
        onFileChanged: {
            brightness = parseInt(this.text());
            root.shouldShowOsd = true;
            hideTimer.restart();
            this.reload();
        }
    }

    Timer {
        id: hideTimer
        interval: 1000
        onTriggered: root.shouldShowOsd = false
    }

    property bool shouldShowOsd: false
    property int maxBrightness: parseInt(maxBrightnessFile.text())
    property int brightness: 0
    property int percentage: (brightness / maxBrightness) * 100

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

							text: '󰃠'

                            color: '#ffcdd6f4'
                            font.pixelSize: 20
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

                            implicitWidth: parent.width * (percentage / 100)
                            radius: parent.radius
                        }
                    }
                }
            }
        }
    }
}
