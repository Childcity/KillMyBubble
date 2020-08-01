#include "gameplaycontroller.h"



GameplayController::GameplayController(QObject *parent)
    : QObject(parent)
{}

GameplayController::GameState GameplayController::gameState() const
{
    return gameState_;
}

QVariantList GameplayController::bubbles() const
{
    return bubbles_;
}

QPoint GameplayController::worldDimension() const
{
    return worldDimension_;
}

void GameplayController::changeGameState(GameplayController::GameState gameState)
{
    if (gameState_ == gameState)
        return;

    if (gameState == GameState::Running) {
        heartBitTimerId = startTimer(heartBitInterval, Qt::TimerType::PreciseTimer);
    } else if (gameState == GameState::Stopped) {
        killTimer(heartBitTimerId);
    } else {
        throw std::invalid_argument("undefined behavior for gameState");
    }

    gameState_ = gameState;
    emit gameStateChanged(gameState_);
}

void GameplayController::setBubbles(QVariantList bubbles)
{
    bubbles_ = bubbles;
}

void GameplayController::setWorldDimension(QPoint worldDimension)
{
    worldDimension_ = worldDimension;
}

void GameplayController::timerEvent(QTimerEvent *)
{
    if (gameState_ == GameState::Stopped)
        return;

    updateGame();
}

void GameplayController::updateGame()
{
    moveBubbles();
}

void GameplayController::moveBubbles()
{
    for (const auto &bubbleVar : bubbles_){
        BubbleState *bubble = BubbleState::CastToPtr(bubbleVar);

        // Move bubble on some delta, according to speed
        bubble->moveByY(static_cast<int>(-defaultBubbleStep * bubble->speed()));

        // Count world maxTop/maxRight according to Bubble state
        // (We think, that in bubble can be resized)
        int maxTop = -bubble->dimension().y();
        int maxRight = worldDimension_.x() - bubble->dimension().x();

        if ((bubble->pos().y() <= maxTop) || bubble->isCurrentlyKilled()) {
            // Move bubble to the bottom
            int newX = getRandomInt(0, maxRight);
            int newY = worldDimension_.y();
            bubble->setPos({newX, newY});

            // Increase speed of bubble
            bubble->speedUp(0.6);

            // If Bubble is not killed -- it has reached to finish
            if (bubble->isCurrentlyKilled()) {
                bubble->setIsCurrentlyKilled(false);
                DEBUGGAM("Bubble has been killed:" << bubble->killedTimes());
            } else {
                bubble->increaseReachedFinishTimes();
            }
        }
    }
}

int GameplayController::getRandomInt(int min, int max)
{
    using std::chrono::system_clock;
    static auto seed = system_clock::now().time_since_epoch().count();
    static std::mt19937 generator(seed);

    max = (max <= min) ? min : max;
    std::uniform_int_distribution<int> distrib(min, max);
    return distrib(generator);
}
