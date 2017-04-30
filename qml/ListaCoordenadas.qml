import VPlayApps 1.0
import VPlay 2.0

import QtQuick 2.0
import QtQuick.XmlListModel 2.0
import "Mapa/"

import GlobalStorage 1.0



NavigationItem{
    title: qsTr("Coordenadas")

    ListPage{

        id: coordenadasPage
        //                listView.header : Rectangle{
        //                    width: coordenadasPage.width
        //                    height: 32
        //                    color: "black"
        //                }
        anchors.fill: parent
        pullToRefreshHandler.pullToRefreshEnabled: true
        pullToRefreshHandler.onRefresh: {
            GlobalStorage.xmlModel.getData()
            console.log("Loading....")
        }
        model: GlobalStorage.xmlModel.firePoints
        delegate: ListFindItem{
            onShowPlace: {
                navigation.currentIndex = 0
                firemap.showPlace(coordinate)
            }
        }
        listView.spacing: 4
        listView.emptyView.children: [DownloadProgressIndicator{}]
//        Text{
//            id: progress
//            anchors.centerIn: parent
//            text: "Text"
//            Connections{
//                target: GlobalStorage.xmlModel
//                onDownloadProgress: {
//                    //  console.log("PROGRESS UPDATE")
//                    progress.text = "Download Progress: " + (received/total).toString()
//                }
//            }
//        }
        FloatingActionButton{
        visible: true
            onClicked: GlobalStorage.xmlModel.sortByProximity(Qt.point(42.358651,-3.634317))

        }
    }

}

