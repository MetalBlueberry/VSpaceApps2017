#ifndef XMLMAPPARSER_H
#define XMLMAPPARSER_H

#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QXmlStreamReader>
#include "firemappoint.h"
#include <QQmlListProperty>

class XmlMapParser : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QQmlListProperty<FireMapPoint> firePoints READ points NOTIFY pointsChanged)
    Q_PROPERTY(QString source READ getSource WRITE setSource NOTIFY sourceChanged)

public:
    explicit XmlMapParser(QObject *parent = 0);

    QQmlListProperty<FireMapPoint> points();

    Q_INVOKABLE void getData();
    void dumpDebugData();
    static FireMapPoint * atFunction(QQmlListProperty<FireMapPoint> *property, int index);
    static int countFunction(QQmlListProperty<FireMapPoint> *property);

    QString source = "https://firms.modaps.eosdis.nasa.gov/active_fire/c6/kml/MODIS_C6_Europe_24h.kml";
    QString getSource()const {return source;}
    void setSource(QString data){
        if(data.compare(source) != 0){
            source = data;
            emit sourceChanged();
        }
    }

signals:
    void pointsChanged();
    void sourceChanged();

private slots:
    void replyFinished(QNetworkReply* reply);

private:
    QList<FireMapPoint*> firePoints;
};

#endif // XMLMAPPARSER_H
