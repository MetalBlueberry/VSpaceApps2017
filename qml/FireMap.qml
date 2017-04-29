import VPlayApps 1.0
import VPlay 2.0

import QtQuick 2.0
import QtPositioning 5.5
import QtLocation 5.5
import "Mapa/"
import BackButtonSignal 1.0
import GlobalStorage 1.0

NavigationItem{
    title: qsTr("Calcifer")

    AppMap {
        id: map
        anchors.fill: parent

        // configure plugin for displaying map here
        // see http://doc.qt.io/qt-5/qtlocation-index.html#plugin-references-and-parameters
        // for a documentation of possible Location Plugins
        plugin: Plugin
        {
            id: plugin
            //Plugin 1
            name: "osm"

            //Plugin 2
            //                name: "mapbox"
            //                parameters: [  PluginParameter {
            //                    name: "mapbox.map_id"
            //                    value: "mapbox.streets"
            //                  },
            //                  PluginParameter {
            //                    name: "mapbox.access_token"
            //                    value: "pk.eyJ1IjoiZ3R2cGxheSIsImEiOiJjaWZ0Y2pkM2cwMXZqdWVsenJhcGZ3ZDl5In0.6xMVtyc0CkYNYup76iMVNQ"
            //                  }]

        }

        copyrightsVisible:  false

        enableUserPosition: true
        showUserPosition: true

        // Center map to Burgos
        center: QtPositioning.coordinate(42.358308, -3.642678)
        zoomLevel: 13
        //onMapClicked: zoomToUserPosition()

        IndicadorSeleccion{
            id:marker
            coordinate: map.center
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                marker.coordinate = map.toCoordinate(Qt.point(mouse.x,mouse.y))
            }
        }

        FloatingActionButton{
            icon: IconType.asterisk
            onClicked: map.zoomToUserPosition()
            visible: true // show on all platforms, default is only Android
            Text {
                anchors.centerIn: parent
                text: myWebStorage.appStartedCounter.toString()
            }
        }
    }
}
