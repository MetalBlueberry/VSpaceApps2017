import VPlayApps 1.0
import QtQuick 2.0

MouseArea{
    height: 100
    width: parent.width
    hoverEnabled: true
    onClicked: {
       // button.color="blue"

    }
    Rectangle{
        id: button
        height: parent.height
        width: parent.width
        color:  parent.containsMouse? "blue": "lightsteelblue"
        //border.width: 2
        //border.color:"black"
        //parent.pressed?
        radius: 10


            /*gradient: Gradient {
                GradientStop { position: 0.0; color: "lightsteelblue" }
                GradientStop { position: 1.0; color: "blue" }
            }*/
        Text{
            anchors.fill: parent
            font.pixelSize: 24
            color:"white"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text:"Longitud: "+ model.cords.x.toString() + " - Latitud: " + model.cords.y.toString()+"\n Localidad:"
        }
    }

}
