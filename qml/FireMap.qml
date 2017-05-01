import VPlayApps 1.0
import VPlay 2.0

import QtQuick 2.7
import QtPositioning 5.5
import QtLocation 5.5
import "Mapa/"
import BackButtonSignal 1.0
import GlobalStorage 1.0

import QtQuick.XmlListModel 2.0

NavigationItem{
    id:base
    title: qsTr("Calcifer")
    function showPlace(coordinate){
        center = coordinate
    }

    property var center: QtPositioning.coordinate(42.358308, -3.642678)
    AppMap {
        id: map
        anchors.fill: parent
        center: base.center
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
        //center: QtPositioning.coordinate(42.358308, -3.642678)
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

        //Función para añadir los fuego al mapa
        Connections{
            id: globalStorageConnection
            target: GlobalStorage.xmlModel
            onPointsChanged:{
                map.update()
                //map.clearMapItems()
                auxModel.clear()
                globalStorageConnection.reloadItems()
                //notesXml.reloadItems()
            }
            function reloadItems(){
                console.log("cargando fuego")
                var auxObj = GlobalStorage.xmlModel.firePoints;
                var auxEndCondition = GlobalStorage.xmlModel.firePoints.length
                for(var x = 0; x < auxEndCondition; x++){
                    var pointObj = auxObj[x]
                    //var circle = Qt.createQmlObject('FireIndicator { punto: Qt.point('+pointObj.cords.x+','+pointObj.cords.y+')}', map)
                    auxModel.append({"x":pointObj.cords.x,"y":pointObj.cords.y})
                    //      console.log(pointObj.cords)
                    //map.addMapItem(circle);
                }
            }
        }
        ListModel{
            id: auxModel
            ListElement{
                x: 0
                y: 0
            }
        }

        MapItemView{
            model: auxModel
            delegate: FireIndicator{
                punto: Qt.point(model.x,model.y)
            }

        }
        //        XmlListModel{
        //            id: notesXml
        //            xml: GlobalStorage.userNotesXml
        //            //source: "http://www.mysite.com/feed.xml"
        //            query: "/Notes/note"
        //            XmlRole { name: "texto"; query: "Texto/string()" }
        //            XmlRole { name: "latitude"; query: "Latitude/string()" }
        //            XmlRole { name: "longitude"; query: "Longitude/string()" }
        //            onXmlChanged: {
        //                map.clearMapItems()
        //                globalStorageConnection.reloadItems()
        //                // notesXml.reloadItems()
        //            }
        //            function reloadItems()
        //            {

        //                console.log("cargando notas")
        //                var auxObj = notesXml;
        //                var auxEndCondition = notesXml.count
        //                for(var x = 0; x < auxEndCondition; x++){
        //                    var pointObj = auxObj[x]
        //                    var note = Qt.createQmlObject('MapNote { }', map)
        //                    //      console.log(pointObj.cords)
        //                    map.addMapItem(note);
        //                }
        //            }
        //        }



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
            // enabled: map.userPositionAvailable
            icon: IconType.asterisk
            onClicked: map.zoomToUserPosition()
            visible: map.userPositionAvailable // show on all platforms, default is only Android

        }
        //        AppSlider {
        //            id: slider
        //            anchors.top: parent.top
        //            anchors.left: parent.verticalCenter
        //            anchors.right: parent.right
        //            from:0
        //            to:1000
        //        }
        AnimatedImage{

            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.margins: dp(10)
            width: dp(50)
            height: dp(50)
            id: activity
            source: "qrc:/qml/img/Fire.gif"
            playing: true
            visible: GlobalStorage.downloadProgress < 1
        }
    }



}
