import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.1

import Qt.labs.controls 1.0 as Labs

Window{

	id: __rootWindow
	visible: true

	property string port
	property int pictureAvailableStep: 600000
	property ListModel situation: ListModel{}
	property ListModel dataSourcesModel: ListModel {}

	width: 320
	height: 480

	ScrollView{
		id: __scrollView

		verticalScrollBarPolicy: Qt.ScrollBarAlwaysOff

		anchors.fill: parent

		Item{
			id: __contentItem
			width: __rootWindow.width
			height: __imageBox.height + __descriptionLabel.height + __infoPalette.height + 50

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
					source: selectedPicture(__swipeView.currentIndex)
					anchors.fill: parent
					opacity: 0.5
				}

				Image{
					id: __placeNamesImage
					source: "http://orm.mipt.ru/archive/" + port + "/placenames.png"
					anchors.fill: parent
					opacity: 0.8
				}

				Labs.SwipeView{
					id: __swipeView

					anchors.fill: parent

					Repeater{
						model: situation

						delegate: Item{ }
					}

					onCurrentIndexChanged: {
						__descriptionLabel.text = situation.get(__swipeView.currentIndex).date.toTimeString()
					}
				}

				Labs.PageIndicator {
					id: __indicator

					count: __swipeView.count
					currentIndex: __swipeView.currentIndex

					anchors.bottom: __swipeView.bottom
					anchors.horizontalCenter: parent.horizontalCenter
				}
			}


			Label{
				id: __descriptionLabel

				anchors.top: __imageBox.bottom
				anchors.topMargin: 10

				anchors.left: parent.left
				anchors.right: parent.right

				horizontalAlignment: Text.AlignHCenter
			}

			Image{
				id: __infoPalette
				source: "http://orm.mipt.ru/DAT/paletka_3.GIF"

				fillMode: Image.PreserveAspectFit

				anchors.top: __descriptionLabel.bottom
				anchors.topMargin: 10

				anchors.left: parent.left
				anchors.right: parent.right
			}
		}
	}

	Component.onCompleted: {
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

		__locationSelector.currentIndex = 0

		fillSituation()
	}

	function selectedPicture(index){
		if(situation.length == 0)
			return ""
		var result = createImageSource(situation.get(index).date)
		return result
	}

	function fillSituation(){
		var count = 12
		var currentDate = new Date() - (count + 2) * pictureAvailableStep
		for(var i = 0; i < count; ++i){
			currentDate += pictureAvailableStep
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
