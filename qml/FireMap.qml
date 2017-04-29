import VPlayApps 1.0
import VPlay 2.0

import QtQuick 2.7
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

        //MapItemView{
        //       Repeater{
        //            id: pointRepeater
        //            //model: GlobalStorage.xmlModel.firePoints
        //            //model: parseInt(GlobalStorage.xmlModel.fireCount.toString())
        //            model: slider.value
        //            delegate: FireIndicator{
        //                //punto: Qt.point(model.cords.x,model.cords.y)
        //                //punto: Qt.point(42.358651,-3.634317);
        //                id: ind
        //                property var pointObj: GlobalStorage.xmlModel.firePoints[model.index]
        //                punto: Qt.point(ind.pointObj.cords.x,ind.pointObj.cords.y)
        //                onPuntoChanged: console.log(punto)
        //            }
        //        }
        Connections{
            target: GlobalStorage.xmlModel
            onPointsChanged:{
                console.log("cargando")
                map.clearMapItems()
                for(var x = 0; x < GlobalStorage.xmlModel.firePoints.length; x++){

                    var pointObj = GlobalStorage.xmlModel.firePoints[x]
                    var circle = Qt.createQmlObject('FireIndicator { punto: Qt.point('+pointObj.cords.x+','+pointObj.cords.y+')}', map)
                        console.log(pointObj.cords)
                    map.addMapItem(circle);
                }
            }
        }


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
                text: GlobalStorage.xmlModel.fireCount.toString()
            }
        }
//        AppSlider {
//            id: slider
//            anchors.top: parent.top
//            anchors.left: parent.verticalCenter
//            anchors.right: parent.right
//            from:0
//            to:1000
//        }
    }
}
