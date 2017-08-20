import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

ApplicationWindow {
    id: app
    visible: true
    width: 640
    height: 480
    title: qsTr("Qml Layouts Test")

    SlideMenu {
        model: ListModel {
            id: modelMenu
            ListElement {
                item: "page_example"
                icon: ""
                page: "PageExample.qml"
            }
            ListElement {
                item: "settings"
                icon: "qrc:/img/icon_settings.png"
                page: "PageSettings.qml"
            }
            ListElement {
                item: "about"
                icon: ""
                page: "PageAbout.qml"
            }
        }
    }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: 0

        FirstPage {}
        SecondPage {}

    }

    PageIndicator {
          id: indicator

          count: swipeView.count
          currentIndex: swipeView.currentIndex

          anchors.bottom: swipeView.bottom
          anchors.horizontalCenter: parent.horizontalCenter
      }
}
