// @pragma UseQApplication

import Quickshell
import QtQuick

import "./widgets/bar"
import "./widgets/osd"

ShellRoot {
	id: root

	Bar {}
	OnScreenDisplay {}
}
