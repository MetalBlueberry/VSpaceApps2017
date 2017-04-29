import VPlayApps 1.0
import VPlay 2.0

import QtQuick 2.0
import QtPositioning 5.5
import QtLocation 5.5
import "Mapa/"
import BackButtonSignal 1.0
import GlobalStorage 1.0


import QtQuick.XmlListModel 2.0
import Calcifer 1.0

App {
    // You get free licenseKeys from https://v-play.net/licenseKey
    // With a licenseKey you can:
    //Connections{
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


    //    WebStorage {
    //        id: myWebStorage

    //        // this can be read in the Text element below
    //        property int appStartedCounter

    //        onInitiallyInServerSyncOrErrorChanged: {
    //            // also increase the app counter, if there is no internet connection
    //            if(initiallyInServerSyncOrError) {
    //                increaseAppStartedCounter()
    //            }
    //        }

    //        function increaseAppStartedCounter() {
    //            var appStarts = myWebStorage.getValue("numAppStarts")
    //            // if the app was started for the first time, this will be undefined; in that case set it to 1
    //            if(appStarts === undefined) {
    //                appStarts = 1
    //            } else {
    //                appStarts++
    //            }
    //            myWebStorage.setValue("numAppStarts", appStarts)

    //            // set the property to the stored value
    //            appStartedCounter = appStarts

    //        }
    //    }
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

        FireMap{

        }
        NavigationItem{
            title: qsTr("Mensajes")

            ListPage{
                XmlMapParser{
                    id: xmlModel

                    Component.onCompleted: xmlModel.getData()
                }
                //                XmlListModel{
                //                    id: xmlModel
                //                   // source: "file:///Users/Victor/Downloads/data.xml"
                //                  //  source: "file:///Users/Victor/Downloads/MODIS_C6_Europe_24h.kml"
                //                    source: "http://firms.modaps.eosdis.nasa.gov/active_fire/c6/kml/MODIS_C6_Europe_24h.kml"
                //                    namespaceDeclarations: "declare namespace media=\"http://www.opengis.net/kml/2.2\";"
                //                   // query: "/kml/Placemark"
                //                    query: "/kml/Document/Folder/Placemark"
                //                    XmlRole { name: "name"; query: "name/string()" }
                //                    XmlRole { name: "point"; query: "Point/coordinates/string()" }
                //                }

                anchors.fill: parent
                pullToRefreshHandler.pullToRefreshEnabled: true
                pullToRefreshHandler.onRefresh: {
                    xmlModel.getData()
                    console.log("Loading....")
                }
                model: xmlModel.firePoints
                delegate: Text{
                    width: 100
                    height: 25
                    text: model.cords.x.toString() + " - " + model.cords.y.toString()
                }
                Text{
                    anchors.centerIn: parent
                   // text:xmlModel.firePoints.length
                }
            }

        }
        Options{}
    }

}
