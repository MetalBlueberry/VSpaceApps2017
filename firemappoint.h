#ifndef FIREMAPPOINT_H
#define FIREMAPPOINT_H

#include <QObject>
#include <QPointF>
class FireMapPoint: public QObject
{
    Q_OBJECT
    Q_PROPERTY(QPointF cords READ getCords NOTIFY cordsChanged)
    Q_PROPERTY(QString description READ getDescription NOTIFY descriptionChanged)
    Q_PROPERTY(QString name READ getName NOTIFY nameChanged)

public:
    explicit FireMapPoint(QObject *parent = 0);

    QPointF cords ;
    QPointF getCords() const{ return cords;}
    void setCordsFromString(QString data);

    QString description;
    QString getDescription() const{return description;}
    void setDescription(QString data);

    QString name;
    QString getName() const{ return name;}
    void setName(QString data);

signals:
    void cordsChanged();
    void descriptionChanged();
    void nameChanged();


};

#endif // FIREMAPPOINT_H
