import QtQuick 2.11
import QtQuick.Controls 2.2

Column {
    spacing: 2

    property int totalKilledInf: 0
    property int totalMissedInf: 0

    Text {
        text: qsTr("Killed: " + totalKilledInf)
        font.family: "Tahoma"
        font.pixelSize: 36
        color: "green"
    }

    Text {
        text: qsTr("Missed:  " + totalMissedInf)
        font.family: "Tahoma"
        font.pixelSize: 36
        color: "red"
    }
}
