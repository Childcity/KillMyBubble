import QtQuick 2.9
import QtQuick.Controls 2.2

Rectangle {
    width: txt.contentWidth + 20
    height: txt.contentHeight + 20
    radius: 15
    border {
        width: 3
        color: "#368be7"
    }

    property int totalKilledInf: 0
    property int totalMissedInf: 0

    Text {
        id: txt
        anchors.fill: parent
        font.pixelSize: 36
        color: "#1c7c1c"
        text: qsTr("Game finished!\n" +
                   "Bubbles missed: " + totalKilledInf + "\n" +
                   "Bubbles blowed: " + totalMissedInf)
        font.family: "Tahoma"
        font.bold: true
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }
}


