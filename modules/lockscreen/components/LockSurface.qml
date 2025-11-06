import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Controls.Fusion
import Quickshell.Wayland

Rectangle {
    id: root
    required property LockContext context

    color: "transparent"

    FontLoader {
        id: fjallaOne
        source: "../assets/FjallaOne-Regular.ttf"
    }

    Image {
        id: image
        anchors.fill: parent
        source: "../assets/wallpaper_layer_0.png"
    }

    MultiEffect {
        source: image
        width: image.width
        height: image.height
        blurEnabled: true
        blurMax: 32
        blur: 1.0
    }

    Column {
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter

            verticalCenterOffset: -greeting.height
        }

        Label {
            id: greeting
            anchors.horizontalCenter: parent.horizontalCenter

            renderType: Text.NativeRendering
            font.family: fjallaOne.name
            font.pointSize: 30

            color: "#33cdd6f4"

            text: "Hey There!"
        }
        Label {
            id: clock
            property var date: new Date()

            // The native font renderer tends to look nicer at large sizes.
            renderType: Text.NativeRendering
            font.family: fjallaOne.name
            font.pointSize: 350

            color: "#aacdd6f4"

            Timer {
                running: true
                repeat: true
                interval: 1000

                onTriggered: clock.date = new Date()
            }

            text: {
                const hours = this.date.getHours().toString().padStart(2, '0');
                const minutes = this.date.getMinutes().toString().padStart(2, '0');
                return `${hours}:${minutes}`;
            }

            MultiEffect {
                id: clock_effect
                source: clock
                anchors.fill: clock

                shadowEnabled: true
                shadowOpacity: 1.0
                shadowColor: "#9911111b"
                shadowScale: 1.0
                shadowBlur: 1
                shadowHorizontalOffset: 0
                shadowVerticalOffset: 0
            }

            state: root.context.showFailure ? "INCORRECT" : root.context.showTyping ? "TYPING" : "NEUTRAL"
            states: [
                State {
                    name: "NEUTRAL"
                    PropertyChanges {
                        target: clock
                        color: "#aacdd6f4"
                    }
                },
                State {
                    name: "INCORRECT"
                    PropertyChanges {
                        target: clock
                        color: "#aaf38ba8"
                    }
                },
                State {
                    name: "TYPING"
                    PropertyChanges {
                        target: clock
                        color: "#aab4befe"
                    }
                }
            ]
            transitions: [
                Transition {
                    from: "*"
                    to: "INCORRECT"
                    ColorAnimation {
                        target: clock
                        duration: 500
                    }
                },
                Transition {
                    from: "*"
                    to: "NEUTRAL"
                    ColorAnimation {
                        target: clock
                        duration: 200
                    }
                },
                Transition {
                    from: "*"
                    to: "TYPING"
                    ColorAnimation {
                        target: clock
                        duration: 300
                    }
                }
            ]
        }
    }

    TextField {
        id: passwordBox

        anchors.bottom: parent.bottom

        padding: 10

        focus: true
        enabled: !root.context.unlockInProgress
        echoMode: TextInput.Password
        inputMethodHints: Qt.ImhSensitiveData

        onTextChanged: root.context.currentText = this.text

        onAccepted: root.context.tryUnlock()

        Connections {
            target: root.context

            function onCurrentTextChanged() {
                passwordBox.text = root.context.currentText;
            }
        }
    }

    Image {
        anchors.fill: parent
        source: "../assets/wallpaper_layer_1.png"
    }

    // Button {
    //     text: "Its not working, let me out"
    //     onClicked: context.unlocked()
    // }
}
