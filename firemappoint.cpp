#include "firemappoint.h"

FireMapPoint::FireMapPoint(QObject *parent): QObject(parent)
{

}

void FireMapPoint::setCordsFromString(QString data)
{
    QStringList split = data.split(',');
    cords = QPointF(split.at(1).toDouble(),split.at(0).toDouble());
    emit cordsChanged();
}

void FireMapPoint::setDescription(QString data)
{
    if(description.compare(data) != 0){
        description = data;
        emit descriptionChanged();
    }
}

void FireMapPoint::setName(QString data)
{
    if(name.compare(data) != 0){
        name = data;
        emit nameChanged();
    }
}
