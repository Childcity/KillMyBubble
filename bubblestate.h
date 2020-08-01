#ifndef BUBBLESTATE_H
#define BUBBLESTATE_H

#include "main.h"

#include <QPoint>

class BubbleState : public QObject {
    Q_OBJECT

    Q_PROPERTY(QPoint pos READ pos WRITE setPos NOTIFY posChanged)
    Q_PROPERTY(QPoint dimension READ dimension WRITE setDimension)
    Q_PROPERTY(double speed READ speed WRITE setSpeed NOTIFY speedChanged)
    Q_PROPERTY(int killedTimes READ killedTimes WRITE setKilledTimes NOTIFY killedTimesChanged)
    Q_PROPERTY(int reachedFinishTimes READ reachedFinishTimes WRITE setReachedFinishTimes NOTIFY reachedFinishTimesChanged)
    Q_PROPERTY(bool isCurrentlyKilled READ isCurrentlyKilled)

public:
    static BubbleState *CastToPtr(const QVariant &var);

public:
    BubbleState(QObject *parent = nullptr);

    QPoint pos() const;

    double speed() const;

    QPoint dimension() const;

    int killedTimes() const;

    int reachedFinishTimes() const;

    bool isCurrentlyKilled() const;

public slots:
    void setPos(QPoint pos);

    void move(QPoint deltaPos);

    void moveByX(int x);

    void moveByY(int y);

    void setSpeed(double speed);

    void speedUp(double delta);

    void setDimension(QPoint dimension);

    void setKilledTimes(int killedTimes);

    void increaseKilledTimes();

    void setReachedFinishTimes(int reachedFinishTimes);

    void increaseReachedFinishTimes();

    void setIsCurrentlyKilled(bool isCurrentlyKilled);

signals:
    void posChanged(QPoint newPos);

    void speedChanged(double speed);

    void killedTimesChanged(int killedTimes);

    void reachedFinishTimesChanged(int reachedFinishTimes);

private:
    static constexpr double defaultSpeed = 1;

    QPoint pos_;
    QPoint dimension_;
    double speed_ = defaultSpeed;
    int killedTimes_ = 0;
    int reachedFinishTimes_ = 0;
    bool isCurrentlyKilled_ = false;
};

#endif // BUBBLESTATE_H
