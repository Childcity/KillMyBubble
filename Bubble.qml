import QtQuick 2.9
import QtQuick.Window 2.3
import BubbleState 1.0

Item {
    id: root
    width: bubble.width
    height: bubble.height

    property alias state: bubbleState
    
    Rectangle {
        id: bubble
        clip: true
        width: 80
        height: 80
        color: "transparent"

        Image {
            source: "img/bubble.png"
            width: 130
            height: 130
            x: parent.x - 27
            y: parent.y - 27
        }
    }

    BubbleState {
        id: bubbleState
        dimension: Qt.point(root.width, root.height)
        onPosChanged: {
            root.x = newPos.x
            root.y = newPos.y
        }
    }

    MouseArea {
        anchors.fill: root
        cursorShape: Qt.PointingHandCursor

        onPressed: {
            bubbleState.increaseKilledTimes()
        }
    }

    // Animation for X movement
    Behavior on x {
        PropertyAnimation  {
            // We must decrease animation speed according to speed of bubble
            duration: 800 / bubbleState.speed
            easing.type: Easing.OutBounce
        }
    }

    // Animation for rotation
    RotationAnimator on rotation {
        target: bubble;
        loops: Animation.Infinite
        duration: 800 / (2*bubbleState.speed)
        from: 0;
        to: 360;
    }
}
