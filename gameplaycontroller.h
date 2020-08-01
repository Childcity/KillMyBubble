#ifndef GAMEPLAYCONTROLLER_H
#define GAMEPLAYCONTROLLER_H

#include "main.h"
#include "bubblestate.h"

#include <QObject>
#include <QTimerEvent>
#include <QVariantList>
#include <QVariantList>
#include <random>

class GameplayController : public QObject {
    Q_OBJECT

    Q_PROPERTY(GameState gameState READ gameState WRITE changeGameState NOTIFY gameStateChanged)
    Q_PROPERTY(QVariantList bubbles READ bubbles WRITE setBubbles)
    Q_PROPERTY(QPoint worldDimension READ worldDimension WRITE setWorldDimension)

public:
    explicit GameplayController(QObject *parent = nullptr);

    enum class GameState {
        Stopped,
        Running
    };
    Q_ENUM(GameState)

    GameState gameState() const;

    QVariantList bubbles() const;

    QPoint worldDimension() const;

signals:
    void gameStateChanged(GameState gameState);


public slots:
    void changeGameState(GameState gameState);

    void setBubbles(QVariantList bubbles);

    void setWorldDimension(QPoint worldDimension);

protected:
    void timerEvent(QTimerEvent *);

    void updateGame();

    void moveBubbles();

    int getRandomInt(int min, int max);

private:
    static constexpr int heartBitInterval = 1000 / 60; // ms.
    static constexpr int defaultBubbleStep = 1;

    GameState gameState_ = GameState::Stopped;
    int heartBitTimerId = 0;
    QVariantList bubbles_;
    QPoint worldDimension_;
};

#endif // GAMEPLAYCONTROLLER_H
