import VPlayApps 1.0
import QtQuick 2.0

App {

    id: item
    color: "white"
    Component.onCompleted: showFullScreen()
    shutdownAppWithEscapeKeyEnabled: true

    Loader{
        id: mainLoader
        visible: false
        anchors.fill: parent
        active: true
        source: "qrc:/qml/Main.qml"
        asynchronous: true
    }
    onSplashScreenFinished: mainLoader.visible = true
}
