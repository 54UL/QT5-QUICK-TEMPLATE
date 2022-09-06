#include <QApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    const QUrl url(QStringLiteral("qrc:template-qml/app.qml"));
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);
    QQmlApplicationEngine engine;
    //Insert here app and engine hook references to do actually real stuff (REGISTER META TYPES TO BE USED IN THE QML ENGINE)
    engine.load(url);
    app.setApplicationName("XUL-TEMPLATE");
    return app.exec();
}
