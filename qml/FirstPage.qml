import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Page {
    id: firstPage

    RowLayout {
        anchors.fill: parent

        ColumnLayout {
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width * 0.65

            RowLayout {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredHeight: parent.width * 0.25
                Test { color: "blue" }

            }

            RowLayout {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredHeight: parent.width * 0.75
                Test { color: "green" }

            }
        }

        ColumnLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredWidth: parent.width * 0.35

            ColumnLayout {
                Layout.alignment: Qt.AlignCenter
                spacing: 20
                Button {
                    Layout.fillWidth: true
                    text: "Button1"
                }

                Button {
                    Layout.fillWidth: true
                    text: "Button2"
                }

                Button {
                    Layout.fillWidth: true
                    text: "Button3"
                }
                Button {
                    Layout.fillWidth: true
                    text: "Button4"
                }
            }
        }
    }
}
