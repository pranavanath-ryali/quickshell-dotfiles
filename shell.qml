// @pragma UseQApplication

import Quickshell
import QtQuick

import "./modules/bar"
import "./modules/osd"
import "./config/Colors.qml"

ShellRoot {
	id: root

	Bar {}
	OnScreenDisplay {}

	// Loader {
	// 	active: true
	// 	source: "modules/bar/Bar.qml"
	// }
	// Loader {
	// 	active: true
	// 	source: "modules/osd/OnScreenDisplay.qml"
	// }
}
