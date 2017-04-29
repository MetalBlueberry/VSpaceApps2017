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
  XmlMapParser{
      id: internalXmlModel

      Component.onCompleted: xmlModel.getData()
  }
}
