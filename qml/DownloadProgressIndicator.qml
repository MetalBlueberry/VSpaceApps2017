import VPlayApps 1.0
import QtQuick 2.0

import QtQuick.Controls 2.1
import GlobalStorage 1.0

Item {
    width: 200
    height: 200

    id: base
    anchors.fill: parent
    AppActivityIndicator{
        id: activity
        anchors.centerIn: parent
    }
    ProgressBar{
        id: bar
        width: dp(200)
        height: 20
        anchors.top: activity.bottom
        anchors.horizontalCenter: activity.horizontalCenter
        from: 0
        to: 1
        //value:
    }
//    Connections{
//        target: GlobalStorage
//        onDownloadProgressChanged:{
//            console.log("Update PRogrss Bar")
//           bar.value = GlobalStorage.downloadProgress
//        }
//    }

}
