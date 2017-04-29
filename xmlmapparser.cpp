#include "xmlmapparser.h"

XmlMapParser::XmlMapParser(QObject *parent):
    QObject(parent),
    firePoints(QList<FireMapPoint*>())
{

}

QQmlListProperty<FireMapPoint> XmlMapParser::points()
{
    return QQmlListProperty<FireMapPoint>(this,&firePoints,&XmlMapParser::countFunction,&XmlMapParser::atFunction);
}

void XmlMapParser::getData()
{
    if( requestRunning ) return;
    requestRunning = true;

    qDebug() << "REQUEST";
    qDebug() << getSource();
    QNetworkAccessManager *manager = new QNetworkAccessManager(this);
    connect(manager, SIGNAL(finished(QNetworkReply*)),
            this, SLOT(replyFinished(QNetworkReply*)));

    QNetworkReply *reply = manager->get(QNetworkRequest(QUrl(getSource())));

    connect(reply,SIGNAL(downloadProgress(qint64,qint64)),this,SIGNAL(downloadProgress(qint64,qint64)));

    for(int x = firePoints.count()-1; x >= 0 ; x--){
        FireMapPoint * p = firePoints.takeAt(x);
        p->deleteLater();
    }
    firePoints.clear();
    emit pointsChanged();
    emit fireCountChanged();
}

void XmlMapParser::dumpDebugData()
{
    for(FireMapPoint * p : firePoints){
        qDebug() << p->getName()  << " " << p->getCords();
    }
}

FireMapPoint *XmlMapParser::atFunction(QQmlListProperty<FireMapPoint> *property, int index)
{
    XmlMapParser *list = qobject_cast<XmlMapParser*>(property->object);
    if(list){
        return list->firePoints.at(index);
    }
    return Q_NULLPTR;
}

int XmlMapParser::countFunction(QQmlListProperty<FireMapPoint> *property)
{
    XmlMapParser *list = qobject_cast<XmlMapParser*>(property->object);
    if(list){
        return list->firePoints.count();
    }
    return -1;
}

void XmlMapParser::replyFinished(QNetworkReply *reply)
{
    qDebug() <<"REPLY";
    //qDebug() << reply->readAll();
    QXmlStreamReader reader(reply);



    if (reader.readNextStartElement()) {
        if (reader.name() == "kml"){
            while(reader.readNextStartElement()){
                if(reader.name() == "Document"){
                    while(reader.readNextStartElement()){
                        if(reader.name() == "Folder"){
                            while(reader.readNextStartElement()){
                                if(reader.name() == "Placemark"){
                                    FireMapPoint *newPoint = new FireMapPoint();
                                    while(reader.readNextStartElement()){
                                        if(reader.name() == "name"){
                                            QString s = reader.readElementText();
                                            newPoint->setName(s);
                                            // qDebug(qPrintable(s));
                                        }else if(reader.name() == "description"){
                                            QString s = reader.readElementText();
                                            newPoint->setDescription(s);
                                            // qDebug(qPrintable(s));
                                        }else if(reader.name() == "Point"){
                                            while(reader.readNextStartElement()){
                                                if(reader.name() == "coordinates"){
                                                    QString s = reader.readElementText();
                                                    newPoint->setCordsFromString(s);
                                                    //qDebug(qPrintable(s));
                                                }else{
                                                    reader.skipCurrentElement();
                                                }
                                            }
                                        }
                                        else
                                            reader.skipCurrentElement();
                                    }
                                    firePoints.append(newPoint);
                                }else{
                                    reader.skipCurrentElement();
                                }
                            }

                        }
                        else
                            reader.skipCurrentElement();
                    }
                }
                else
                    reader.skipCurrentElement();
            }
        }
        else
            reader.raiseError(QObject::tr("Incorrect file"));
    }
    emit pointsChanged();
    emit fireCountChanged();
    // dumpDebugData();
    delete sender();
    requestRunning = false;
}
