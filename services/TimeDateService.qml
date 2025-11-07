pragma Singleton

import Quickshell
import QtQuick

Singleton {
	property string hour: {
		Qt.formatDateTime(clock.date, "hh")
	}
	property string min: {
		Qt.formatDateTime(clock.date, "mm")
	}

	property string year: {
		Qt.formatDate(clock.date, "yyyy")
	}
	property string longMonth: {
		Qt.formatDate(clock.date, "MMMM")
	}
	property string day: {
		Qt.formatDate(clock.date, "dd")
	}

	SystemClock {
		id: clock
		precision: SystemClock.Minutes
	}
}
