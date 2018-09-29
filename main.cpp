#include <QGuiApplication>
#include <QQmlContext>
#include <QQmlApplicationEngine>
#include "FraxionActivity.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    app.setOrganizationName("xavi-b");
    app.setApplicationName("FRAXION");

    FraxionActivity fraxionActivity;

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;
    engine.rootContext()->setContextProperty("FraxionActivity", &fraxionActivity);

    return app.exec();
}
