import VPlayApps 1.0
import QtQuick 2.0
import QtPositioning 5.5
import QtLocation 5.5

App {
    // You get free licenseKeys from https://v-play.net/licenseKey
    // With a licenseKey you can:
    //  * Publish your games & apps for the app stores
    //  * Remove the V-Play Splash Screen or set a custom one (available with the Pro Licenses)
    //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
    //licenseKey: "<generate one from https://v-play.net/licenseKey>"

    Page {
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
            copyrightsVisible:  false;
            enableUserPosition: true
            showUserPosition: true
            // Center map to Burgos
            center: QtPositioning.coordinate(42.358308, -3.642678)
            zoomLevel: 13
            //onMapClicked: zoomToUserPosition()
            FloatingActionButton{
                icon: IconType.asterisk
                onClicked: map.zoomToUserPosition()
                visible: true // show on all platforms, default is only Android
            }
        }


    }
}
