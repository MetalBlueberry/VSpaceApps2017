import VPlayApps 1.0
import QtQuick 2.7
import QtPositioning 5.5
import QtLocation 5.5
import GlobalStorage 1.0

MapQuickItem {
    property point punto: Qt.point(42.358651,-3.634317);
    property real mapZoom: 1
    property bool isVisibleOnMap: false
    id: fireIndicator
    visible: isVisibleOnMap
    // onIsVisibleOnMapChanged: if(isVisibleOnMap)console.log("Visible")
    // border.color: "black"
    //border.width: 0
    smooth: true
    opacity: 0.25
    //radius: GlobalStorage.markerSize === 1? 1000: 375
    coordinate: QtPositioning.coordinate(punto.x, punto.y)
    zoomLevel: Math.min(12.5,mapZoom)

    sourceItem:Item{
        width: (GlobalStorage.markerSize === 1? 100: 37.5)// * widthScale
        height: width

        Rectangle{
            //scale: fireIndicator.mapZoom
            id: point
            //  property real widthScale: 1
            anchors.centerIn: parent
            width: parent.width//(GlobalStorage.markerSize === 1? 100: 37.5)// * widthScale
            height: width
            radius: width
            transformOrigin: Item.Center
            color: "red"

            ParallelAnimation  {
                id: pointAnimation
                //condiciones finales
                onStopped: {point.scale = 1; point.opacity = 1}

                alwaysRunToEnd: true
                running: fireIndicator.zoomLevel != 12.5
                loops: Animation.Infinite
                // ParallelAnimation{
                OpacityAnimator {
                    target: point
                    from:1
                    to:0
                    duration: 1000
                    easing.type: Easing.OutCubic
                }
                ScaleAnimator  {

                    target: point
                    from:0
                    to:1
                    duration: 1000
                    easing.type: Easing.OutCubic
                }
                //   }
                //Es necesario para que se pueda detener la animación, no hace nada realmente
                PropertyAction{
                    target: point
                    property: "scale"
                    value: 1
                }
            }
            //            SequentialAnimation {
            //                alwaysRunToEnd: true
            //                running: fireIndicator.zoomLevel != 12.5
            //                loops: Animation.Infinite

            //                PropertyAction{
            //                    target: point
            //                    property: "scale"
            //                    value: 1
            //                }
            //            }
        }
        //        SequentialAnimation  on widthScale {


        //        }

    }
    anchorPoint.x: point.width / 2
    anchorPoint.y: point.height / 2

}

