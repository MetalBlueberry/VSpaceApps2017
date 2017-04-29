import VPlayApps 1.0
import QtQuick 2.0
import QtPositioning 5.5
import QtLocation 5.5
import BackButtonSignal 1.0


MapQuickItem {
    id:base
    sourceItem: Image{
        id: image
        //color: "black"
        width: 420
        height: 280
        sourceSize.width: image.width
        sourceSize.height: image.height
        fillMode: Image.Stretch
      //  radius: width
        source: "qrc:/qml/img/ventana_nota.svg"

        Rectangle{
            width: image.width - 40
            height: image.height/2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset:  -image.height/5
            radius: 10
            color: "white"
            AppTextEdit{
//                width: parent.width
//                height: parent.height
                anchors.margins: 8
                anchors.fill: parent
                placeholderText: qsTr("Escribe un mensaje")
                font.pixelSize: sp(14)
            }
        }
        AppButton{
            id: btGuardarNota
            text: "Guardar"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset:  image.height/6
            width: 200
            height: 50
            visible: true
            fontBold: true
        }

    }

    anchorPoint.x: image.width / 2
    anchorPoint.y: image.height

}
