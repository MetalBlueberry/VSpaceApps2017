import VPlayApps 1.0
import QtQuick 2.0
import QtPositioning 5.5
import QtLocation 5.5
import BackButtonSignal 1.0


MapQuickItem {
    id:base
    sourceItem: Image{
        //color: "black"
        width: dp(32)/10
        height: width
      //  radius: width
      //  source: url de la imagen
        id: image
        Rectangle{
            anchors.centerIn: parent
            width: parent.width*10
            height: width
            id: aura
            radius: width
            color: "transparent"
            border.color: "black"
            border.width: dp(2.5)
            ParallelAnimation {
                running: true
                loops:  Animation.Infinite
                NumberAnimation{target: aura; property: "width"; duration: 1000 ; from: dp(24) ; to: dp(32); easing.type: Easing.OutCubic }
                NumberAnimation{target: aura; property: "opacity"; duration: 1000 ; from: 1 ; to: 0;  easing.type: Easing.OutCubic}
            }


        }
    }

    anchorPoint.x: image.width / 2
    anchorPoint.y: image.height

}
