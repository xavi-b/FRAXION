#include "FraxionActivity.h"

FraxionActivity::FraxionActivity(QObject *parent)
    : QObject(parent),
      _activityStr("net/xavib/fraxion/FraxionActivity")
{

}

void FraxionActivity::notify(QString content)
{
    QAndroidJniObject::callStaticMethod<void>(_activityStr.toStdString().c_str(),
                                              "notify",
                                              "(Ljava/lang/String;)V",
                                              QAndroidJniObject::fromString(content).object<jstring>());
}

void FraxionActivity::vibrate(int msecs)
{
    QAndroidJniObject::callStaticMethod<void>(_activityStr.toStdString().c_str(), "vibrate", "(I)V", msecs);
}

void FraxionActivity::ringtone()
{
    QAndroidJniObject::callStaticMethod<void>(_activityStr.toStdString().c_str(), "ringtone", "()V");
}
