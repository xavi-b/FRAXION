#ifndef FRAXIONACTIVITY_H
#define FRAXIONACTIVITY_H

#include <QObject>

#ifdef __ANDROID__
    #include <QAndroidJniObject>
#endif

class FraxionActivity : public QObject
{
    Q_OBJECT
private:
    QString _activityStr;

public:
    explicit FraxionActivity(QObject *parent = nullptr);

signals:

public slots:
    void notify(QString content);
    void vibrate(int msecs);
    void ringtone();
};

#endif // FRAXIONACTIVITY_H
