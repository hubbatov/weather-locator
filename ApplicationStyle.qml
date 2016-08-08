pragma Singleton

import QtQuick 2.0

QtObject {
	property color backgroundColor: "#353637"
	property color textColor: "#F2F2F2"

	property int animationInterval: 200
	property int reconnectionInterval: 5000
	property int pageAvailableInterval: 600000
}

