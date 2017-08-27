import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3


ApplicationWindow {
    id: app
    property variant parameters
    visible: true
    width: 640
    height: 480
    title: qsTr("Qml Layouts Test")

    StackView {
        id:stackView
        anchors.fill: parent
        initialItem: Page {
            Test {color: "green"}
        }
    }

    SlideMenu {
        model:     ListModel {
            ListElement {
                item: "First page"
                page: "qrc:/qml/FirstPage.qml"
            }
            ListElement {
                item: "Second page"
                page: "qrc:/qml/SecondPage.qml"
            }
            ListElement {
                item: "Gps sample"
                page: "qrc:/qml/GPS_Sample.qml"
            }
        }

        onMenuItemClicked: {
            stackView.push(page)
        }

    }


}
