// @pragma UseQApplication

import Quickshell
import QtQuick

import "./modules/bar"

ShellRoot {
	id: root

	Loader {
		active: true
		source: "modules/bar/Bar.qml"
	}
	Loader {
		active: true
		source: "modules/osd/shell.qml"
	}
}
