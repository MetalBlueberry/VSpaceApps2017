import VPlayApps 1.0
import VPlay 2.0

import QtQuick 2.0
import QtPositioning 5.5
import QtLocation 5.5

import BackButtonSignal 1.0
import GlobalStorage 1.0

import QtQuick.XmlListModel 2.0
import Calcifer 1.0

Item {
    anchors.fill: parent
    opacity: visible? 1 : 0
    Behavior on opacity{
    NumberAnimation{duration: 500}
    }
    // You get free licenseKeys from https://v-play.net/licenseKey
    // With a licenseKey you can:
    //Connections{
    //  * Publish your games & apps for the app stores
    //  * Remove the V-Play Splash Screen or set a custom one (available with the Pro Licenses)
    //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
    //licenseKey: "<generate one from https://v-play.net/licenseKey>"
    //   parent.onClosing: {
    //        //Detectar si estamos en android
    //        //if (Qt.platform.os == "android")

    //        //Lanzar señal de cerrado a la aplicación
    //        BackButtonSignal.notify(close);

    //        //Capturar Señal
    //        //Connections{
    //        //  target: BackButtonSignal
    //        //  onNotifyClose: close.accepted = false
    //        //}

    //        //Cancelar cerrado de la aplicación
    //        //close.accepted = false;
    //    }

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
            id:firemap
        }
        ListaCoordenadas{}
        Options{}
        //VentanaNota{}
    }

}
