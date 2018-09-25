QT += quick
CONFIG += c++11

DEFINES += QT_DEPRECATED_WARNINGS

SOURCES += \
        main.cpp \
        FraxionActivity.cpp

HEADERS += \
    FraxionActivity.h

RESOURCES += qml.qrc


android: {

QT += androidextras

DISTFILES += \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat \
    android/src/net/xavib/fraxion/FraxionActivity.java

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

}

DISTFILES += \
    android/res/drawable/icon.png


