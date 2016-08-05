import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.1

import Qt.labs.controls 1.0 as Labs

import "."

Window{

	id: __rootWindow
	visible: true

	property string port
	property ListModel situation: ListModel{}
	property ListModel dataSourcesModel: ListModel {}
	property int currentIndex: 0

	color: ApplicationStyle.backgroundColor

	width: 320
	height: 480

	Timer{
		id: __updateFramesTimer
		interval: ApplicationStyle.pageAvailableInterval
		running: true
		onTriggered: {
			start()
		}
	}

	Timer{
		id: __reconnectionTimer
		interval: ApplicationStyle.reconnectionInterval
		repeat: false
		onTriggered: {
			start()
		}
	}

	Timer{
		id: __animateTimer
		interval: ApplicationStyle.animationInterval
		repeat: true
		onTriggered: {
			if(currentIndex < situation.count - 1)
				currentIndex = currentIndex + 1
			else
				__animateTimer.stop()
		}
	}

	Rectangle{
		id: __errorConnectionSticker

		anchors.fill: parent

		color: ApplicationStyle.backgroundColor

		BusyIndicator{
			width: 150
			height: 150

			anchors.centerIn: parent

			running: __errorConnectionSticker.visible
		}

		CustomLabel{
			anchors.bottom: parent.bottom; anchors.bottomMargin: 10
			anchors.horizontalCenter: parent.horizontalCenter

			text: qsTr("Пытаюсь подключиться к сети Интернет")
		}
	}

	ScrollView{
		id: __scrollView

		verticalScrollBarPolicy: Qt.ScrollBarAlwaysOff

		visible: !__errorConnectionSticker.visible

		anchors.fill: parent

		Item{
			id: __contentItem
			width: __rootWindow.width
			height: __imageBox.height + __descriptionLabel.height + __infoPalette.height + 70

			Labs.ComboBox{
				id: __locationSelector

				anchors.top: parent.top

				anchors.left: parent.left
				anchors.right: parent.right

				model: dataSourcesModel

				textRole: "name"

				delegate: Labs.ItemDelegate {
					height: active ? 35 : 0
					width: __locationSelector.width
					checkable: false
					autoExclusive: true
					checked: false
					text: active ? name : ""
				}

				onCurrentIndexChanged: {
					port = dataSourcesModel.get(currentIndex).source
				}
			}

			Item{
				id: __imageBox

				anchors.top: __locationSelector.bottom

				width: __rootWindow.width
				height: width

				Image{
					id: __bordersImage
					source: "http://orm.mipt.ru/archive/" + port + "/borders.png"
					anchors.fill: parent
					opacity: 0.8
				}

				Image{
					id: __currentFrameImage
					source: selectedPicture(currentIndex)
					anchors.fill: parent
					opacity: 0.6
				}

				Image{
					id: __placeNamesImage
					source: "http://orm.mipt.ru/archive/" + port + "/placenames.png"
					anchors.fill: parent
					opacity: 0.8
				}

				MouseArea{
					anchors.fill: parent

					property var summary: 0
					property int step: width / situation.count
					property int pressedX: 0

					anchors.bottom: parent.bottom
					anchors.horizontalCenter: parent.horizontalCenter

					propagateComposedEvents: false
					scrollGestureEnabled: false
					preventStealing: true

					onPressed: {
						pressedX = mouseX
					}

					onMouseXChanged: {
						if(summary >= 0 && summary < situation.count)
							summary += ( ( mouseX - pressedX ) / step / 2)

						if(summary < 0) summary = 0
						if(summary > situation.count - 1) summary = situation.count - 1

						currentIndex = summary

						__descriptionLabel.text = situation.get(currentIndex).date.toTimeString()

						pressedX = mouseX
					}
				}
			}

			CustomLabel{
				id: __descriptionLabel

				anchors.bottom: __imageBox.bottom
				anchors.horizontalCenter: parent.horizontalCenter

				font.pointSize: 14
				color: ApplicationStyle.textColor

				horizontalAlignment: Text.AlignHCenter

				text: situation.count > 0 ? situation.get(currentIndex).date.toTimeString() : ""
			}

			InfoPalette{
				id: __infoPalette

				anchors.top: __descriptionLabel.bottom
				anchors.topMargin: 10

				anchors.left: parent.left; anchors.leftMargin: 10
				anchors.right: parent.right; anchors.rightMargin: 10
			}
		}
	}

	Component.onCompleted: {
		start()
	}

	function start(){
		var connectionMade = doesConnectionExist()
		if(connectionMade)
			connectionAccepted()
		else
			__reconnectionTimer.start()
	}

	function doesConnectionExist() {
		var xhr = new XMLHttpRequest()
		var file = "http://orm.mipt.ru/DAT/vld.gif"

		xhr.open('HEAD', file, false);

		try {
			xhr.send();

			if (xhr.status >= 200 && xhr.status < 304) {
				return true;
			} else {
				return false;
			}
		} catch (e) {
			return false;
		}
	}

	function connectionAccepted(){
		__errorConnectionSticker.visible = false

		fillSources()

		__locationSelector.currentIndex = 0

		fillSituation()

		__descriptionLabel.text = situation.get(currentIndex).date.toTimeString()
	}

	function selectedPicture(index){
		if(situation.count == 0)
			return ""
		var result = createImageSource(situation.get(index).date)
		return result
	}

	function fillSources(){
		dataSourcesModel.clear()

		dataSourcesModel.append({source: "port3", name: "Тверь", active: true})
		dataSourcesModel.append({source: "port1", name: "Крылатское", active: true})
		dataSourcesModel.append({source: "port2", name: "Калуга", active: true})
		dataSourcesModel.append({source: "port4", name: "Нижний Новгород", active: false})
		dataSourcesModel.append({source: "port5", name: "Смоленск", active: false})
		dataSourcesModel.append({source: "port6", name: "Валдай", active: false})
		dataSourcesModel.append({source: "port7", name: "Пулково", active: true})
		dataSourcesModel.append({source: "port8", name: "Минск", active: true})
		dataSourcesModel.append({source: "port9", name: "Самара", active: false})
		dataSourcesModel.append({source: "port10", name: "Киев", active: true})
		dataSourcesModel.append({source: "port11", name: "Внуково", active: false})
		dataSourcesModel.append({source: "port13", name: "Запорожье", active: true})
		dataSourcesModel.append({source: "port14", name: "Ростов-на-Дону", active: false})
		dataSourcesModel.append({source: "port15", name: "Анапа", active: true})
		dataSourcesModel.append({source: "port16", name: "Адлер", active: true})
		dataSourcesModel.append({source: "port17", name: "Краснодар", active: false})
		dataSourcesModel.append({source: "port18", name: "МинВоды", active: false})
		dataSourcesModel.append({source: "port19", name: "Брест", active: false})
		dataSourcesModel.append({source: "port20", name: "Волгоград", active: false})
		dataSourcesModel.append({source: "port22", name: "Ульяновск", active: true})
		dataSourcesModel.append({source: "port23", name: "Екатеринбург", active: true})
		dataSourcesModel.append({source: "port24", name: "Валдай", active: true})
		dataSourcesModel.append({source: "port25", name: "Пермь", active: true})
		dataSourcesModel.append({source: "port26", name: "Южно-Сахалинск", active: false})
		dataSourcesModel.append({source: "port27", name: "Хабаровск", active: true})
		dataSourcesModel.append({source: "port28", name: "МинВоды", active: false})
		dataSourcesModel.append({source: "port29", name: "Смоленск", active: true})
		dataSourcesModel.append({source: "port30", name: "Волгоград", active: true})
		dataSourcesModel.append({source: "port31", name: "Казань", active: true})
		dataSourcesModel.append({source: "port32", name: "Ижевск", active: true})
		dataSourcesModel.append({source: "port33", name: "Брянск", active: true})
		dataSourcesModel.append({source: "port34", name: "Шереметьево", active: true})
		dataSourcesModel.append({source: "port35", name: "Архангельск", active: true})
		dataSourcesModel.append({source: "port36", name: "Ставрополь", active: true})
		dataSourcesModel.append({source: "port37", name: "Уфа", active: false})
		dataSourcesModel.append({source: "port38", name: "Ахун", active: true})
		dataSourcesModel.append({source: "port39", name: "Кострома", active: true})
		dataSourcesModel.append({source: "port40", name: "Петрозаводск", active: true})
		dataSourcesModel.append({source: "port41", name: "Оренбург", active: true})
		dataSourcesModel.append({source: "port42", name: "Профсоюзная", active: false})
		dataSourcesModel.append({source: "port43", name: "Владивосток", active: true})
		dataSourcesModel.append({source: "port44", name: "Барабинск", active: true})
		dataSourcesModel.append({source: "port45", name: "Внуково", active: true})
		dataSourcesModel.append({source: "port46", name: "Нижний Новгород", active: true})
		dataSourcesModel.append({source: "port47", name: "Вологда", active: true})
		dataSourcesModel.append({source: "port48", name: "Элиста", active: false})
		dataSourcesModel.append({source: "port49", name: "Миллерово", active: false})
		dataSourcesModel.append({source: "port50", name: "Киров", active: true})
		dataSourcesModel.append({source: "port52", name: "Самара", active: true})
	}

	function fillSituation(){
		situation.clear()

		var count = 15
		var currentDate = new Date() - (count + 2) * ApplicationStyle.pageAvailableInterval
		for(var i = 0; i < count; ++i){
			currentDate += ApplicationStyle.pageAvailableInterval
			situation.append({ date: new Date(currentDate)})
		}
	}

	function createImageSource(date){
		var str = 'http://orm.mipt.ru/archive/' + port + '/';
		str += date.getFullYear().toString() + '_';
		str += (date.getMonth() + 1).toString() + '_';
		str += date.getDay().toString() + '_';
		str += date.getHours().toString() + '_';

		var minutes = date.getMinutes()
		minutes -= (minutes % 10)
		str += minutes + '.png';

		return str;
	}
}
