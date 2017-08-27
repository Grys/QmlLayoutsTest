import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item {
    id: menuView
    width: parent.width * 0.8
    height: parent.height
    z: 3
    x: -width

    property color bgCoclor: "#FFFFFF"
    property color darkPrimary: "#303F9F"
    property color primaryText: "#212121"
    property color currentHighlightItem: "#dcdcdc"
    property var model

    signal menuItemClicked(var item, var page)

    property bool menuIsShown: Math.abs(
                                   menuView.x) < (menuView.width * 0.5) ? true : false

    Behavior on x {
        NumberAnimation {
            duration: 500
            easing.type: Easing.OutQuad
        }
    }

    MouseArea {
        anchors.top: parent.top
        anchors.left: parent.right
        height: parent.height
        width: menuView.menuIsShown ? menuView.parent.width
                                      - menuView.width : menuView.parent.width * 0.1
        drag {
            target: menuView
            axis: Drag.XAxis
            minimumX: -menuView.width
            maximumX: 0
        }

        onClicked: {
            x = 0
        }
        onReleased: {
            if (Math.abs(menuView.x) > 0.5 * menuView.width) {
                menuView.x = -menuView.width //close the menu
            } else {
                menuView.x = 0 //fully opened
            }
        }
    }

    ColumnLayout {
        id: menuColumn
        //Layout.preferredWidth: parent.width
        anchors.top: parent.top
        anchors.left: parent.left
        width: parent.width
        height: parent.height

        Rectangle {
            anchors.fill: parent
            color: menuView.bgCoclor
            z: -1
        }

        ListView {
            id: listViewMenu
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            clip: true
            model: menuView.model
            delegate: componentDelegate
        }

        Component {
            id: componentDelegate

            Rectangle {
                id: wrapperItem
                height: 40
                width: parent.width
                color: wrapperItem.ListView.isCurrentItem
                       || ma.pressed ? menuView.currentHighlightItem : "transparent"
                Image {
                    id: imgItem
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 0.5 * imgItem.width
                    height: parent.height * 0.5
                    width: height
                    source: icon ? icon : ""
                    visible: icon ? true: false
                    smooth: true
                    antialiasing: true
                }

                Label {
                    id: textItem
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: imgItem.right
                    anchors.leftMargin: 0.7 * imgItem.width
                    text: item
                    font.pixelSize: parent.height * 0.3
                    color: wrapperItem.ListView.isCurrentItem ? menuView.darkPrimary : menuView.primaryText
                }

                MouseArea {
                    id: ma
                    anchors.fill: parent
                    onClicked: {
                        menuView.menuItemClicked(item, page)
                        listViewMenu.currentIndex = index
                        menuView.x= -width
                    }
                }
            }
        }
    }
}
