pragma Singleton
import VPlay 2.0
import QtQuick 2.0
//import VPlayPlugins 1.0
import Calcifer 1.0
WebStorage {
    id: myWebStorage
    property alias xmlModel: internalXmlModel
    // this can be read in the Text element below
    property int appStartedCounter



    onInitiallyInServerSyncOrErrorChanged: {
        // also increase the app counter, if there is no internet connection
        if(initiallyInServerSyncOrError) {
            increaseAppStartedCounter()
            userNotes = myWebStorage.getValue("userNotes");
        }

    }

    function increaseAppStartedCounter() {
        var appStarts = myWebStorage.getValue("numAppStarts")
        // if the app was started for the first time, this will be undefined; in that case set it to 1
        if(appStarts === undefined) {
            appStarts = 1
        } else {
            appStarts++
        }
        myWebStorage.setValue("numAppStarts", appStarts)

        // set the property to the stored value
        appStartedCounter = appStarts
    }

    property string userNotes: ""
    property string userNotesXml: "<?xml version=\"1.0\" encoding=\"UTF-8\" ?><Notes>" + userNotes + "</Notes>";

    function addNote(texto,latitude, longiude){
        var appNotes = myWebStorage.getValue("userNotes")

        if(appStarts === undefined) {
            appNotes = "";
        }

        appNotes += "<Nota>"
        appNotes += "<Texto>"
        appNotes += texto
        appNotes += "</Texto>"

        appNotes += "<Latitude>"
        appNotes += latitude
        appNotes += "</Latitude>"

        appNotes += "<Longitude>"
        appNotes += longiude
        appNotes += "</Longitude>"
        appNotes += "</Nota>"

        myWebStorage.setValue("userNotes", appNotes)

        userNotes = appNotes
    }
    function updateNotes() {
        myWebStorage.synchWithServer()
    }

    XmlMapParser{
        id: internalXmlModel
      //  source: "file:///C:/Users/ortegas/Desktop/MODIS_C6_Europe_24h.kml"
        Component.onCompleted: xmlModel.getData()
        //onDownloadProgress: console.log("PRORESS UPDATE")
    }
}
