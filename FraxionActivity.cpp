#include "FraxionActivity.h"

FraxionActivity::FraxionActivity(QObject *parent)
    : QObject(parent),
      _activityStr("net/xavib/fraxion/FraxionActivity")
{

}

void FraxionActivity::notify(QString content)
{
#ifdef __ANDROID__
    QAndroidJniObject::callStaticMethod<void>(_activityStr.toStdString().c_str(),
                                              "notify",
                                              "(Ljava/lang/String;)V",
                                              QAndroidJniObject::fromString(content).object<jstring>());
#endif
}

void FraxionActivity::vibrate(int msecs)
{
#ifdef __ANDROID__
    QAndroidJniObject::callStaticMethod<void>(_activityStr.toStdString().c_str(), "vibrate", "(I)V", msecs);
#endif
}

void FraxionActivity::ringtone()
{
#ifdef __ANDROID__
    QAndroidJniObject::callStaticMethod<void>(_activityStr.toStdString().c_str(), "ringtone", "()V");
#endif
}
