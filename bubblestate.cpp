#include "bubblestate.h"

BubbleState *BubbleState::CastToPtr(const QVariant &var)
{
    return qvariant_cast<BubbleState *>(var);
}

BubbleState::BubbleState(QObject *parent)
    : QObject(parent)
{}

QPoint BubbleState::pos() const
{
    return pos_;
}

double BubbleState::speed() const
{
    return speed_;
}

QPoint BubbleState::dimension() const
{
    return dimension_;
}

int BubbleState::killedTimes() const
{
    return killedTimes_;
}

int BubbleState::reachedFinishTimes() const
{
    return reachedFinishTimes_;
}

bool BubbleState::isCurrentlyKilled() const
{
    return isCurrentlyKilled_;
}

void BubbleState::setPos(QPoint pos)
{
    if (pos_ == pos)
        return;

    pos_ = pos;
    emit posChanged(pos_);
}

void BubbleState::move(QPoint deltaPos)
{
    setPos(pos_ + deltaPos);
}

void BubbleState::moveByX(int x)
{
    move({x, 0});
}

void BubbleState::moveByY(int y)
{
    move({0, y});
}

void BubbleState::setSpeed(double speed)
{
    speed_ = speed;
    emit speedChanged(speed_);
}

void BubbleState::speedUp(double delta)
{
    setSpeed(speed_ + delta);
}

void BubbleState::setDimension(QPoint dimension)
{
    dimension_ = dimension;
}

void BubbleState::setKilledTimes(int killedTimes)
{
    if (killedTimes_ == killedTimes)
        return;

    isCurrentlyKilled_ = true;
    killedTimes_ = killedTimes;
    emit killedTimesChanged(killedTimes_);
}

void BubbleState::increaseKilledTimes()
{
    setKilledTimes(killedTimes_ + 1);
}

void BubbleState::setReachedFinishTimes(int reachedFinishTimes)
{
    if (reachedFinishTimes_ == reachedFinishTimes)
        return;

    reachedFinishTimes_ = reachedFinishTimes;
    emit reachedFinishTimesChanged(reachedFinishTimes_);
}

void BubbleState::increaseReachedFinishTimes()
{
    setReachedFinishTimes(reachedFinishTimes_ + 1);
}

void BubbleState::setIsCurrentlyKilled(bool isCurrentlyKilled)
{
    isCurrentlyKilled_ = isCurrentlyKilled;
}
