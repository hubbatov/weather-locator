import QtQuick 2.5

import "."

Row{
	id: __row

	property string description: ""
	property color color: "#ffffff"

	height: __descriptionLabel.height
	width: parent.width - 30

	Rectangle {
		color: __row.color;
		width: 15
		height: __descriptionLabel.height
		border.color: "black"
		anchors.verticalCenter: parent.verticalCenter
	}

	CustomLabel{
		text: " - "
		anchors.verticalCenter: parent.verticalCenter
	}

	CustomLabel {
		id: __descriptionLabel
		text: __row.description
		width: __row.width - 15
		anchors.verticalCenter: parent.verticalCenter
	}
}

