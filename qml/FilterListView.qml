import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3

Page {
    id: faqScreen
    //anchors.fill: parent
    width: parent.width
    height: parent.height

    ListModel {
        id: faqModel
        ListElement {
            question: "This is first question"
            answer: "This is first question content. It should be showed after expanding item."
        }
        ListElement {
            question: "This is second question"
            answer: "This is second question content. It should be showed after expanding item. this is long text sample. It shoud be transferred on next line. This is third question content. It should be showed after expanding item. this is long text sample. It shoud be transferred on next line."
        }
        ListElement {
            question: "This is third question"
            answer: "This is third question content. It should be showed after expanding item."
        }
    }

    ColumnLayout {
        width: parent.width
        height: parent.height

        TextField {
            id: questionFilter
            Layout.fillWidth: true
            text: ""
            focus: true
            selectByMouse: true

            background: Item {
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: height
                Image {
                    id: logo
                    anchors.fill: parent
                    anchors.margins: 3
                    source: "qrc:/img/icon_settings.png"
                    fillMode: Image.PreserveAspectFit
                }
            }

            onTextChanged: searchFilter.updateFilters()

            padding: 10
            leftPadding: 40
        }

        ListView {
            id: faqListView
            width: parent.width
            height: parent.height - questionFilter.height

            model: FilterModel {
                id: searchFilter
                model:faqModel
                condition: function(entry) {
                    var textMatch = new RegExp(".*"+questionFilter.text+".*", "i");
                    var include = true
                    if(!entry.question.match(textMatch)) {
                        include = false;
                    }
                    return include
                }

                delegate: itemDelegate
            }


        }


        Component {
            id: itemDelegate
            Page {
                id: rowPage

                width: parent.width

                Behavior on implicitHeight {
                    NumberAnimation {
                        duration: 500
                    }
                }

                clip: true

                property bool expanded: false
                header: ToolButton {
                    id: headerItem
                    width: parent.width

                    contentItem: Text {
                        text: model.question
                        font.bold: true
                        font.pointSize: 10
                    }

                    onClicked: {
                        rowPage.expanded = !rowPage.expanded
                    }
                }

                Loader {
                    anchors.left: parent.left
                    anchors.right: parent.right

                    sourceComponent: rowPage.expanded ? dataComponent : dummyComponent

                    Component {
                        id: dataComponent
                        Text {
                            id: answerText
                            text: model.answer
                            font.pointSize: 10
                            wrapMode: Text.WordWrap
                        }
                    }

                    Component {
                        id: dummyComponent
                        Item {
                        }
                    }
                }

                footer: HorizontalLine {
                    color: "#bfbfbf"
                }
            }
        }
    }
}
