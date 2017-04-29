import VPlayApps 1.0
import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import GlobalStorage 1.0
NavigationItem{
    title: qsTr("Opciones")
    id:base
    property var periodoDato: "1"
    property var rangoDato: "1"
    property var zoneDato: "Europe"

    //property var kmlWolrd_24h_100m: "https://firms.modaps.eosdis.nasa.gov/active_fire/c6/kml/MODIS_C6_Global_24h.kml"
    //property var kmlWolrd_24h_300m: "https://firms.modaps.eosdis.nasa.gov/active_fire/viirs/kml/VNP14IMGTDL_NRT_Global_24h.kml"
    //property var kmlWolrd_48h_100m: "https://firms.modaps.eosdis.nasa.gov/active_fire/c6/kml/MODIS_C6_Global_48h.kml"
    //property var kmlWolrd_48h_300m: "https://firms.modaps.eosdis.nasa.gov/active_fire/viirs/kml/VNP14IMGTDL_NRT_Global_48h.kml"

    property var kmlEurope_24h_100m: "https://firms.modaps.eosdis.nasa.gov/active_fire/c6/kml/MODIS_C6_Europe_24h.kml"
    property var kmlEurope_24h_300m: "https://firms.modaps.eosdis.nasa.gov/active_fire/viirs/kml/VNP14IMGTDL_NRT_Europe_24h.kml"
    property var kmlEurope_48h_100m: "https://firms.modaps.eosdis.nasa.gov/active_fire/c6/kml/MODIS_C6_Europe_48h.kml"
    property var kmlEurope_48h_300m: "https://firms.modaps.eosdis.nasa.gov/active_fire/viirs/kml/VNP14IMGTDL_NRT_Europe_48h.kml"

    ListPage{
        id: btopciones
        ColumnLayout {
            Column {
                id: periodo
                Label {
                    text: qsTr("Periodo")
                    font.bold: true
                    font.pixelSize: 18
                }
                RadioButton {
                    checked: true
                    text: qsTr("24h")
                    onClicked: {
                        periodoDato = "1"
                        changeKmlSource()
                    }
                }
                RadioButton {
                    text: qsTr("48h")
                    onClicked: {
                        periodoDato = "2"
                        changeKmlSource()
                    }
                }
            }

            Rectangle{
                color: "lightgray"
                width: btopciones.width
                height: 1
            }

            Column{
                id: rango
                Label {
                    text: qsTr("Rango")
                    font.bold: true
                    font.pixelSize: 18
                }
                RadioButton {
                    checked: true
                    text: qsTr("100m")
                    onClicked: {
                        rangoDato = "1"
                        changeKmlSource()
                    }
                }
                RadioButton {
                    text: qsTr("300m")
                    onClicked: {
                        rangoDato = "2"
                        changeKmlSource()
                    }
                }
            }
        }
    }
    function changeKmlSource(){
        if(zoneDato == "Europe"){
            if(periodoDato == 1 && rangoDato == 1){
                //            xmlModel.source = kmlWolrd_24h_100m
                GlobalStorage.xmlModel.source = kmlEurope_24h_100m
                console.log(kmlWolrd_24h_100m)
            }else if(periodoDato == 1 && rangoDato == 2){
                //            xmlModel.source = kmlWolrd_24h_300m
                GlobalStorage.xmlModel.source = kmlEurope_24h_300m
                console.log(kmlWolrd_24h_300m)
            }else if(periodoDato == 2 && rangoDato == 1){
                //            xmlModel.source = kmlWolrd_48h_100m
                GlobalStorage.xmlModel.source = kmlEurope_48h_100m
                console.log(kmlWolrd_48h_100m)
            }else{
                //            xmlModel.source = kmlWolrd_48h_300m
                GlobalStorage.xmlModel.source = kmlEurope_48h_300m
                console.log(kmlWolrd_48h_300m)
            }
        }
    }
}
