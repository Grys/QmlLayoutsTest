#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/qml/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    QObject *item = engine.rootObjects().first();
    Q_ASSERT(item);

    QVariantMap parameters;
    parameters[QStringLiteral("osm.useragent")] = QStringLiteral("QtLocation Mapviewer example");

    QMetaObject::invokeMethod(item, "initializeProviders",
                              Q_ARG(QVariant, QVariant::fromValue(parameters)));


    return app.exec();
}
