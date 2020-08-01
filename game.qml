import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.2
import GameplayController 1.0

Window {
    title: qsTr("Kill [My] Bubble 🎈")
    id: wnd
    width: 480
    height: 480
    visible: true

    readonly property int bubbleHeight: 80
    readonly property int maxMissedBubbles: 20
    property int totalKilled: 0
    property int totalMissed: 0

    ScoreInfo {
        id: score
        totalKilledInf: totalKilled
        totalMissedInf: totalMissed
    }

    Repeater {
        id: bubbles
        model: 5
        Bubble {
            state.pos: Qt.point(index*100, wnd.height - bubbleHeight)
            state.onKilledTimesChanged: totalKilled++
            state.onReachedFinishTimesChanged: {
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
        gameController.changeGameState(0)
    }
}
