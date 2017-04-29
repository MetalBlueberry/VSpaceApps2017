import VPlayApps 1.0
import QtQuick 2.0
import QtPositioning 5.5
import QtLocation 5.5

MapCircle {
    property point punto: Qt.point(42.358651,-3.634317);
    id: fireIndicator
    color: "red"
       // border.color: "black"
        border.width: 0
        smooth: true
        opacity: 0.25
        radius: 10000
        center: QtPositioning.coordinate(punto.x, punto.y)

        /*Location{
            coordinate: QtPositioning.coordinate(punto.x, punto.y)
        }*/

}

