import Quickshell
import Quickshell.Io
import QtQuick

Item {
    id: workspacesBinaryClock
    visible: true

    implicitWidth: 65
    implicitHeight: parent.height

    property Component binaryColumn: Column {
        Text {
            id: binaryText8
            text: ""

            color: 'red'

            font {
                pixelSize: 4
            }
        }
        Text {
            id: binaryText4
            text: ""

            color: 'green'

            font {
                pixelSize: 4
            }
        }
        Text {
            id: binaryText2
            text: ""

            color: 'blue'

            font {
                pixelSize: 4
            }
        }
        Text {
            id: binaryText1
            text: ""

            color: 'white'

            font {
                pixelSize: 4
            }
        }
    }

    Row {
        spacing: 2

        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
