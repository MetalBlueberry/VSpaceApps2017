pragma Singleton
import VPlayApps 1.0
import QtQuick 2.0

Item {
    signal notifyClose(var close)
    id: item
    function notify(close){
        notifyClose(close);
    }
}
