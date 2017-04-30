import VPlayApps 1.0
import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import GlobalStorage 1.0
NavigationItem{
    title: qsTr("Opciones")
    id:base
    property int periodoDato: 1
    property int rangoDato: 1
    property var zonaDato: "Europe"

    //property var kmlWolrd_24h_100m: "https://firms.modaps.eosdis.nasa.gov/active_fire/c6/kml/MODIS_C6_Global_24h.kml"
    //property var kmlWolrd_24h_300m: "https://firms.modaps.eosdis.nasa.gov/active_fire/viirs/kml/VNP14IMGTDL_NRT_Global_24h.kml"
    //property var kmlWolrd_48h_100m: "https://firms.modaps.eosdis.nasa.gov/active_fire/c6/kml/MODIS_C6_Global_48h.kml"
    //property var kmlWolrd_48h_300m: "https://firms.modaps.eosdis.nasa.gov/active_fire/viirs/kml/VNP14IMGTDL_NRT_Global_48h.kml"

    property var kmlEurope_24h_100m: "https://firms.modaps.eosdis.nasa.gov/active_fire/c6/kml/MODIS_C6_Europe_24h.kml"
    property var kmlEurope_24h_300m: "https://firms.modaps.eosdis.nasa.gov/active_fire/viirs/kml/VNP14IMGTDL_NRT_Europe_24h.kml"
    property var kmlEurope_48h_100m: "https://firms.modaps.eosdis.nasa.gov/active_fire/c6/kml/MODIS_C6_Europe_48h.kml"
    property var kmlEurope_48h_300m: "https://firms.modaps.eosdis.nasa.gov/active_fire/viirs/kml/VNP14IMGTDL_NRT_Europe_48h.kml"

    Page{
        id: btopciones
        ColumnLayout {
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            anchors.bottomMargin: 10
            anchors.topMargin: 10
            anchors.fill: parent
            spacing: 5
            Label{
            text: qsTr("Elige la fuente de datos")
            }
            Column {
                id: periodo
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Label {
                    text: qsTr("Periodo")
                    font.bold: true
                    font.pixelSize: sp(18)
                }
                RadioButton {
                    width: btopciones.width
                    checked: true
                    text: qsTr("24 h")
                    font.pixelSize: sp(18)
                    onClicked: {
                        periodoDato = 1
                        changeKmlSource()
                    }
                }
                RadioButton {
                    width: btopciones.width
                    text: qsTr("48 h")
                    font.pixelSize: sp(18)
                    onClicked: {
                        periodoDato = 2
                        changeKmlSource()
                    }
                }
            }

            Rectangle{
                color: "lightgray"
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                width: btopciones.width
                height: 1
            }

            Column{
                id: rango
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Label {
                    text: qsTr("Rango")
                    font.bold: true
                    font.pixelSize: sp(18)
                }
                RadioButton {
                    width: btopciones.width
                    checked: true
                    text: qsTr("1 km")
                    font.pixelSize: sp(18)
                    onClicked: {
                        rangoDato = 1
                        changeKmlSource()
                    }
                }
                RadioButton {
                    width: btopciones.width
                    text: qsTr("375 m")
                    font.pixelSize: sp(18)
                    onClicked: {
                        rangoDato = 2
                        changeKmlSource()
                    }
                }
            }

            Rectangle {
                id: rectangle
                width: 200
                height: 200
                color: "#00000000"
                visible: true
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }
    function changeKmlSource(){
        GlobalStorage.markerSize = rangoDato;
        if(zonaDato == "Europe"){
            if(periodoDato == 1 && rangoDato == 1){
                //            xmlModel.source = kmlWolrd_24h_100m
                GlobalStorage.xmlModel.source = kmlEurope_24h_100m
                console.log(kmlEurope_24h_100m)
            }else if(periodoDato == 1 && rangoDato == 2){
                //            xmlModel.source = kmlWolrd_24h_300m
                GlobalStorage.xmlModel.source = kmlEurope_24h_300m
                console.log(kmlEurope_24h_300m)
            }else if(periodoDato == 2 && rangoDato == 1){
                //            xmlModel.source = kmlWolrd_48h_100m
                GlobalStorage.xmlModel.source = kmlEurope_48h_100m
                console.log(kmlEurope_48h_100m)
            }else{
                //            xmlModel.source = kmlWolrd_48h_300m
                GlobalStorage.xmlModel.source = kmlEurope_48h_300m
                console.log(kmlEurope_48h_300m)
            }
        }
    }
}
