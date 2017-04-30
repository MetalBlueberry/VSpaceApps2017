#include "xmlmapparser.h"

#include <algorithm>

XmlMapParser::XmlMapParser(QObject *parent):
    QObject(parent),
    firePoints(QList<FireMapPoint*>())
{
    connect(this,SIGNAL(sourceChanged()),this,SLOT(clearListOnSourceChanged()));
}

QQmlListProperty<FireMapPoint> XmlMapParser::points()
{
    return QQmlListProperty<FireMapPoint>(this,&firePoints,&XmlMapParser::countFunction,&XmlMapParser::atFunction);
}

void XmlMapParser::getData()
{
    //qDebug() << "TRY REQUEST";
    if( requestRunning ) return;
    requestRunning = true;

    qDebug() << "REQUEST";
    qDebug() << getSource();
    QNetworkAccessManager *manager = new QNetworkAccessManager(this);
    connect(manager, SIGNAL(finished(QNetworkReply*)),
            this, SLOT(replyFinished(QNetworkReply*)));

    clearListOnSourceChanged();
    reply = manager->get(QNetworkRequest(QUrl(getSource())));

    connect(reply,SIGNAL(downloadProgress(qint64,qint64)),this,SIGNAL(downloadProgress(qint64,qint64)));



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
    //qDebug() << "Counting";
    XmlMapParser *list = qobject_cast<XmlMapParser*>(property->object);
    if(list){
        return list->firePoints.count();
    }
    return -1;
}

QPointF XmlMapParser::currentUserPosition = QPointF(42.358651,-3.634317);
bool XmlMapParser::lessThan(const FireMapPoint* a, const FireMapPoint* b)
{
    return a->distanceToPoint(XmlMapParser::currentUserPosition) < b->distanceToPoint(XmlMapParser::currentUserPosition);
}



// int doComparison()
// {
//     [..]
//     QList<QVariant> fieldsList;

//     // Add items to fieldsList.

//     qSort(fieldsList.begin(), fieldsList.end(), variantLessThan);
// }

void XmlMapParser::sortByProximity(QPointF userPosition)
{
    //qDebug() << "Sorting";
    XmlMapParser::currentUserPosition = userPosition;
    std::sort(firePoints.begin(), firePoints.end(), XmlMapParser::lessThan);
    emit pointsChanged();
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
    sortByProximity(currentUserPosition);
    emit pointsChanged();
    emit fireCountChanged();
    // dumpDebugData();
    delete sender();
    requestRunning = false;
}

void XmlMapParser::clearListOnSourceChanged()
{
    //qDebug() <<"Cleaning";
    //    if(reply  != Q_NULLPTR && reply->isOpen()) {
    //        //if(reply->isOpen()){
    //            reply->abort();

    //        //}

    //        //reply->deleteLater();
    //    }
    requestRunning = false;
    while(!firePoints.isEmpty()){
        FireMapPoint * p = firePoints.takeFirst();
        p->deleteLater();
    }
    firePoints.clear();
    emit pointsChanged();
    emit downloadProgress(0,1);
}
