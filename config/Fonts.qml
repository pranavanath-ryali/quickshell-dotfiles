pragma Singleton

import Quickshell
import QtQuick

Singleton {
	property var regularProperties: font {
		weight: 500
		pixelSize: 12
	}
	property var boldProperties: font {
		weight: 800
		pixelSize: 12
	}
}
