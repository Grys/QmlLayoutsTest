import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

import QtPositioning 5.8
import QtLocation 5.3


Page {
    width: parent.width
    height: parent.height

    BusyIndicator {
        id: bInd
        running: false
    }

    ColumnLayout {
        RowLayout {

        Label { Layout.preferredWidth: 100; text: "latitude:" }
        TextField {
            id: latitude
            text: "0"
        }
        }

        RowLayout {

        Label { Layout.preferredWidth: 100; text: "longitude:" }
        TextField {
            id: longitude
            text: "0"
        }
        }

        Label {
            id: addr
            Layout.preferredWidth: app.width
            Layout.preferredHeight: 50
            Test {color: "blue"}

            wrapMode: Text.WordWrap
            text: ""
        }

        Button {
            text: "Get Address"
            onClicked: {
                geocodeModel.query = QtPositioning.coordinate(
                            parseFloat(latitude.text),
                            parseFloat(longitude.text))
                geocodeModel.update()
            }
        }

        Button {
            text: "Update coord"
            onClicked: {

                if (posSource.supportedPositioningMethods === PositionSource.NoPositioningMethods)
                    console.log('No supported methods')

                if (posSource.supportedPositioningMethods === PositionSource.SatellitePositioningMethods)
                    console.log('Sattellite methos')

                if (posSource.supportedPositioningMethods === PositionSource.NonSatellitePositioningMethods)
                    console.log('Non sattelite method')

                if (posSource.supportedPositioningMethods === PositionSource.AllPositioningMethods)
                    console.log('Both satteliite and non sattellite')

                bInd.running = true
                posSource.update()
            }
        }
    }


    PositionSource {
        id: posSource

        onPositionChanged: {
            if (posSource.position.latitudeValid && posSource.position.longitudeValid)
            {
                latitude.text = posSource.position.coordinate.latitude
                longitude.text =posSource.position.coordinate.longitude
            }
            bInd.running = false
        }

        onSourceErrorChanged: {
            bInd.running = false
            console.log('Source error: ')
        }

        onUpdateTimeout: {
            console.log('Timeout update')
        }
    }

    GeocodeModel {
        id: geocodeModel
        plugin: Plugin {
            name: "osm"
            parameters: PluginParameter {
                name: "osm.useragent"
                value: "osm.useragent=QtLocation Mapviewer example"
            }
        }

        onStatusChanged: {
            if (status===GeocodeModel.Error) addr.text = errorString
            console.log('Status changed: ' + status + ', err: ' + errorString)
        }

        onLocationsChanged: {
            var addrLocation = get(0).address
            addr.text = get(0).address.text
        }
    }
}
