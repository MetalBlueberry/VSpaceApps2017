import VPlayApps 1.0
import QtQuick 2.0
import QtPositioning 5.5
import QtLocation 5.5
import BackButtonSignal 1.0


MapQuickItem {
    id:base
    sourceItem: Rectangle{
        width: dp(32)
        height: width
        id: image
        radius: width
        color: "transparent"
        border.color: "red"
        border.width: dp(1)
        Rectangle{
            anchors.centerIn: parent
            color: "orange"
            width: parent.width /10
            height: width
            radius: width
        }

    }

    anchorPoint.x: image.width / 2
    anchorPoint.y: image.height / 2

}
