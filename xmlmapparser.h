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
    //Q_PROPERTY(bool loading READ loading WRITE setLoading NOTIFY loadingChanged)
    Q_PROPERTY(int fireCount READ getFireCount NOTIFY fireCountChanged)
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
        //if(data.compare(source) != 0){
        source = data;
        emit sourceChanged();
        //}
    }

    //int fireCount= 0;
    int getFireCount() const{return firePoints.length();}
    static bool lessThan(const FireMapPoint *a, const FireMapPoint *b);

static QPointF currentUserPosition;

public slots:
    void sortByProximity(QPointF userPosition);

signals:
    void pointsChanged();
    void sourceChanged();
    void fireCountChanged();
    void downloadProgress(qint64 received,qint64 total);


private slots:
    void replyFinished(QNetworkReply* reply);
    void clearListOnSourceChanged();

private:
    QList<FireMapPoint*> firePoints;
    bool requestRunning = false;



    QNetworkReply *reply = Q_NULLPTR;
};

#endif // XMLMAPPARSER_H
