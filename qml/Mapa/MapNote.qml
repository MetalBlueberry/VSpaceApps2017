import VPlayApps 1.0
import QtQuick 2.0
import QtPositioning 5.5
import QtLocation 5.5
import BackButtonSignal 1.0
import QtQuick.Layouts 1.3

MapQuickItem {
    id:base

    property bool estadoVentana: true
    property bool ventanaEstadoTipo
    property var mensaje

    sourceItem: Rectangle{
        id: ventanaNota
        height: image.height + puntoNota.height/2
        width: image.width
        color: "transparent"
        Rectangle{
            id: puntoNota
            width: 30
            height: width
            radius: width

            color: "#8ebbf5"
            border.color: "white"
            border.width: 4
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.bottom
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    toggleVentana()
                }
            }
        }

        Image{
            id: image
            width: 420
            height: 280
            sourceSize.width: image.width
            sourceSize.height: image.height
            fillMode: Image.Stretch
            source: "qrc:/qml/img/ventana_nota.svg"
            visible: false
            ColumnLayout {
                anchors.fill: parent
                anchors.bottomMargin: parent.height / 2.2
                anchors.leftMargin: 15
                anchors.rightMargin: 15
                anchors.topMargin: 15
                Rectangle{
                    anchors.fill: parent
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset:  -image.height/5
                    radius: 10
                    color: "white"
                    AppTextEdit{
                        id: etNota
                        anchors.margins: 8
                        anchors.fill: parent
                        placeholderText: qsTr("Escribe un mensaje")
                        font.pixelSize: sp(14)
                        visible: false
                    }

                    AppText{
                        id: tvNota
                        anchors.margins: 8
                        anchors.fill: parent
                        text: mensaje
                        font.pixelSize: sp(14)
                        horizontalAlignment : Text.AlignHCenter
                        verticalAlignment : Text.AlignVCenter
                        visible: false
                    }
                }
                AppButton{
                    id: btGuardarNota
                    text: "Guardar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: etNota.bottom
                    anchors.topMargin: 20
                    width: 200
                    height: 50
                    fontBold: true
                    visible: false
                }
            }
        }
    }

    anchorPoint.x: ventanaNota.width / 2
    anchorPoint.y: ventanaNota.height

    function toggleVentana(){
        tipoVentana()
        image.visible = estadoVentana
        estadoVentana = !estadoVentana
    }
    function tipoVentana(){
        etNota.visible = ventanaEstadoTipo
        btGuardarNota.visible = ventanaEstadoTipo
        tvNota.visible = !ventanaEstadoTipo
    }
}
