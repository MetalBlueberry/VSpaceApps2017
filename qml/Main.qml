import VPlayApps 1.0
import VPlay 2.0

import QtQuick 2.0
import QtPositioning 5.5
import QtLocation 5.5
import "Mapa/"
import BackButtonSignal 1.0
import GlobalStorage 1.0

import QtQuick.XmlListModel 2.0


App {
    // You get free licenseKeys from https://v-play.net/licenseKey
    // With a licenseKey you can:
    //  * Publish your games & apps for the app stores
    //  * Remove the V-Play Splash Screen or set a custom one (available with the Pro Licenses)
    //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
    //licenseKey: "<generate one from https://v-play.net/licenseKey>"
    onClosing: {
        //Detectar si estamos en android
        //if (Qt.platform.os == "android")

        //Lanzar señal de cerrado a la aplicación
        BackButtonSignal.notify(close);

        //Capturar Señal
        //Connections{
        //  target: BackButtonSignal
        //  onNotifyClose: close.accepted = false
        //}

        //Cancelar cerrado de la aplicación
        //close.accepted = false;
    }

    WebStorage {
        id: myWebStorage

        // this can be read in the Text element below
        property int appStartedCounter

        onInitiallyInServerSyncOrErrorChanged: {
            // also increase the app counter, if there is no internet connection
            if(initiallyInServerSyncOrError) {
                increaseAppStartedCounter()
            }
        }

        function increaseAppStartedCounter() {
            var appStarts = myWebStorage.getValue("numAppStarts")
            // if the app was started for the first time, this will be undefined; in that case set it to 1
            if(appStarts === undefined) {
                appStarts = 1
            } else {
                appStarts++
            }
            myWebStorage.setValue("numAppStarts", appStarts)

            // set the property to the stored value
            appStartedCounter = appStarts

        }
    }
    //inicializa el módulo de comunicación
    VPlayGameNetwork {
        id: gameNetwork
        // created in the V-Play Web Dashboard
        gameId: 351
        secret: "AdFrnTP9juOKQgy0Etxs"
        gameNetworkView: myGameNetworkView
        facebookItem: facebook

        Component.onCompleted: {
            GlobalStorage.gameNetworkItem = gameNetwork
        }

    }// VPlayGameNetwork

    Navigation{
        id: navigation

        navigationMode: navigationModeDrawer
        navigationDrawerItem : Text {
            text: "Open"
            anchors.centerIn: parent
            color: navigation.navigationDrawerItemPressed ? "red" : "green"
        }

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
        NavigationItem{
            title: qsTr("Mensajes")

            ListPage{

                XmlListModel{
                    id: xmlModel
                   // source: "file:///Users/Victor/Downloads/data.xml"
                  //  source: "file:///Users/Victor/Downloads/MODIS_C6_Europe_24h.kml"
                    source: "http://firms.modaps.eosdis.nasa.gov/active_fire/c6/kml/MODIS_C6_Europe_24h.kml"
                    namespaceDeclarations: "declare namespace media=\"http://www.opengis.net/kml/2.2\";"
                   // query: "/kml/Placemark"
                    query: "/kml/Document/Folder/Placemark"
                    XmlRole { name: "name"; query: "name/string()" }
                    XmlRole { name: "point"; query: "Point/coordinates/string()" }
                }

                anchors.fill: parent
                pullToRefreshHandler.pullToRefreshEnabled: true
                pullToRefreshHandler.onRefresh: {
                    xmlModel.reload()
                    console.log("Loading....")
                }
                model: xmlModel
                delegate: Text{
                    width: 100
                    height: 25
                    text: model.point
                }
                Text{
                    anchors.centerIn: parent
                    text:xmlModel.progress.toString()
                }
            }

        }

    }
    //    AppDrawer{
    //                //drawerPosition: drawerPositionLeft
    //                Rectangle{
    //                    anchors.fill: parent
    //                    color: "white"
    //                    radius: 10
    //                }
    //            }
    //    AppDrawer{
    //        drawerPosition: drawerPositionRight
    //        Rectangle{
    //            anchors.fill: parent
    //            color: "white"
    //            radius: 10
    //        }
    //    }
}
