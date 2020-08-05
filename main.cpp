#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "bubblestate.h"
#include "gameplaycontroller.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    {
        qmlRegisterType<BubbleState>("BubbleState", 1,0, "BubbleState");
        qmlRegisterType<GameplayController>("GameplayController", 1,0, "GameplayController");
        qRegisterMetaType<GameplayController::GameState>("GameplayController::GameState");
    }

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/qml/game.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [&url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(EXIT_FAILURE);
        }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
