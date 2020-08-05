import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.2
import GameplayController 1.0

Window {
    title: qsTr("Kill [My] Bubble 🎈")
    id: wnd
    minimumWidth: gameOverText.visible ? gameOverText.implicitWidth : score.implicitWidth
    minimumHeight: gameOverText.visible ? gameOverText.implicitHeight : score.implicitHeight
    width: 480
    height: 480
    visible: true

    readonly property int maxMissedBubbles: 20
    readonly property int maxBubblesNumber: 5
    property int totalKilled: 0
    property int totalMissed: 0

    ScoreInfo {
        id: score
        totalKilledInf: totalKilled
        totalMissedInf: totalMissed
    }

    Repeater {
        id: bubbles
        model: maxBubblesNumber

        Bubble {
            state.pos: getStartBubblePosByIndex(index)
            state.onKilledTimesChanged: totalKilled++
            state.onReachedFinishTimesChanged: {
                // arg1: reachedFinishTimes
                if (reachedFinishTimes <= 0) {
                    return
                }

                if (totalMissed < maxMissedBubbles){
                    totalMissed++
                }

                if (isGameOver()) {
                    stopGame()
                }
            }
        }
    }

    GameOverInfo {
        id: gameOverText
        totalKilledInf: totalKilled
        totalMissedInf: totalMissed
        anchors.centerIn: parent
        visible: false

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                var oldDimensionJs = bubbles.itemAt(0).state.dimension
                var oldDimensionPoint = Qt.point(oldDimensionJs.x, oldDimensionJs.y)
                for (var i = 0; i < bubbles.count; ++i) {
                    bubbles.itemAt(i).state.reset()
                    bubbles.itemAt(i).state.setDimension(oldDimensionPoint)
                    bubbles.itemAt(i).state.setPos(getStartBubblePosByIndex(i))
                    bubbles.itemAt(i).visible = true
                }

                wnd.totalKilled = 0
                wnd.totalMissed = 0

                // Make visible score
                score.visible = true

                // Make visible GameOver text
                gameOverText.visible = false

                // Start game
                gameController.changeGameState(GameplayController.Running)
            }
        }
    }

    function isGameOver() {
        return totalMissed >= maxMissedBubbles;
    }

    function stopGame() {
        // Stop gameController
        gameController.changeGameState(GameplayController.Stopped)

        // Make invisible all bubbles
        for (var i = 0; i < bubbles.count; ++i) {
            bubbles.itemAt(i).visible = false;
        }

        // Make invisible score
        score.visible = false

        // Make visible GameOver text
        gameOverText.visible = true
    }

    function getStartBubblePosByIndex(index) {
        var oneBubbleWidth = wnd.width / maxBubblesNumber
        return Qt.point(index * oneBubbleWidth, wnd.height)
    }

    GameplayController {
        id: gameController

        onGameStateChanged: {
            console.log("onGameStateChanged: ", gameState)
        }
    }

    function updateWorldDimension() {
        gameController.setWorldDimension(Qt.point(wnd.width, wnd.height))
    }

    onWidthChanged: updateWorldDimension()

    onHeightChanged: updateWorldDimension()

    Component.onCompleted: {
        updateWorldDimension()

        // Create an array
        // and set Bubbles states to the gameController
        var bubblesStates = new Array(bubbles.count);
        for (var i = 0; i < bubblesStates.length; ++i) {
            bubblesStates[i] = bubbles.itemAt(i).state;
        }
        gameController.setBubbles(bubblesStates)

        // Start game
        gameController.changeGameState(GameplayController.Running)
    }

    Component.onDestruction: {
        gameController.changeGameState(GameplayController.Stopped)
    }
}
