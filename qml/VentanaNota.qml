import VPlayApps 1.0
import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3

NavigationItem{
    title: qsTr("Mensaje")
    Page{
        id: listMensaje
        Column {
            id: column
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            anchors.bottomMargin: 10
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.fill: parent
            spacing: 10
            //anchors.fill: parent
            move:Transition{
                NumberAnimation {
                    //targets: [object]
                    properties: "x,y"
                    duration: 300
                }
            }


            AppTextEdit{
                id: taMensaje
                placeholderText: qsTr("Escribe un mensaje")
                width:column.width
                height: Math.max(contentHeight,50)
                anchors.horizontalCenter: parent.horizontalCenter
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                textFormat: Text.AutoText
                Layout.maximumHeight: 3000
                Layout.minimumHeight: 50
                font.pixelSize: sp(18)

            }

            AppButton{
                id: btGuardar
                text: "Guardar"
                //  anchors.top: taMensaje.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                // anchors.topMargin: 10
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                width: 200
                height: 50

            }




        }
    }
}

