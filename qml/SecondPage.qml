import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Page {
    id: secondPage

    ListView {
        id: listview
        anchors.fill: parent
        model:testModel

        delegate: Page {
            id:linePage
            width: parent.width
            height: textHeader.implicitHeight
            clip: true
            Behavior on height {
                NumberAnimation {
                    duration: 600
                    easing.type: Easing.OutQuad
                }
            }

            header: Text {
                id: textHeader
                font.pointSize: 14
                text: model.q
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (linePage.height==header.implicitHeight)
                        {
                            linePage.height = textElement.implicitHeight
                        } else {
                            linePage.height = header.implicitHeight
                        }
                    }
                }
                HorizontalLine {}
            }

            Text {
                id: textElement
                font.pointSize: 14
                width: parent.width
                text: model.a
                wrapMode: Text.Wrap
            }            
        }
    }



    ListModel {
        id: testModel
        ListElement {
            q: "First question"
            a: "First question expanding content. First question expanding content. First question expanding content. First question expanding content. First question expanding content. First question expanding content. First question expanding content."
        }
        ListElement {
            q: "Second question"
            a: "Second question expanding content. Second question expanding content. Second question expanding content. Second question expanding content. Second question expanding content. Second question expanding content. Second question expanding content."
        }
        ListElement {
            q: "Third question"
            a: "Third question expanding content. Third question expanding content. Third question expanding content. Third question expanding content. Third question expanding content. Third question expanding content. Third question expanding content."
        }
    }
}
