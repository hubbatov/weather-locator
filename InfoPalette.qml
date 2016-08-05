import QtQuick 2.0

import "."

Column{
	id: __infoPalette

	width: parent.width

	InfoPaletteRow{ color: "#666666"; description: qsTr("область за пределами зоны обзора") }
	InfoPaletteRow{ color: "#CCCCCC"; description: qsTr("зона обзора, в которой радиоэхо меньше порогового") }
	InfoPaletteRow{ color: "#009999"; description: qsTr("облачность без выпадающих до земли осадков") }
	InfoPaletteRow{ color: "#0099CC"; description: qsTr("слабые осадки") }
	InfoPaletteRow{ color: "#0066CC"; description: qsTr("осадки") }
	InfoPaletteRow{ color: "#0000CC"; description: qsTr("ливневые осадки") }
	InfoPaletteRow{ color: "#000066"; description: qsTr("сильные ливневые осадки") }
	InfoPaletteRow{ color: "#CCCC00"; description: qsTr("мощные кучево-дождевые облака") }
	InfoPaletteRow{ color: "#CC9900"; description: qsTr("грозовые облака (молнии 50 - 75%)") }
	InfoPaletteRow{ color: "#CC6600"; description: qsTr("грозовые облака (молнии 75 - 90%") }
	InfoPaletteRow{ color: "#CC0000"; description: qsTr("грозовые облака (молнии >90%)") }
	InfoPaletteRow{ color: "#66CC00"; description: qsTr("грозо-градовые облака с мелким градом") }
	InfoPaletteRow{ color: "#009900"; description: qsTr("грозо-градовые облака с градом") }
	InfoPaletteRow{ color: "#CC0099"; description: qsTr("зона шквалового усиления ветра выше 15 м/с") }
	InfoPaletteRow{ color: "#CC00CC"; description: qsTr("зона шквалового усиления ветра выше 20 м/с") }
}
