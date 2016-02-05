import QtQuick 2.0

Rectangle {
    Background {
                id: background
            }
    objectName: "screen1"
    id: screen2
    width: parent.width
    height: parent.height/1.5
    border.color: "black"
    anchors.top:parent.top
    Rectangle{
        id:deck1titlewraper
        width: parent.width
        height: 35
        color: "transparent"
        Image{
            source: "images/g.png"
            anchors.bottom: parent.bottom
               fillMode: Image.PreserveAspectFit
               width: parent.width
               smooth: true
        }
  Text {
        anchors {
            margins: units.gu(1)
            fill: parent
        }
        id: deck1
        text: qsTr("Deck-2")
        font.bold: true
        font.pointSize: 10
        horizontalAlignment: Text.AlignHCenter
        color: "white"
  }//heading end
}//wrapper end

    //start vinyl shit
    Rectangle{
    id:vinyldisk1
    anchors {
        margins: units.gu(1)
        //fill: parent
        top: deck1titlewraper.bottom
    }
    width: parent.width
    height:parent.height/1.4
    color: "transparent"
   // border.color: "#ffffff"
    Image {
        id: vinyldisk
        source: "images/vinyl.png"
        fillMode: Image.PreserveAspectFit
        smooth: true
        width: parent.width
        opacity: 0.5
    }
    } //end vinyl shit

    //controls
    Rectangle {
        id: control2
        Image {
            id: bg
            source: "images/h.png"
            anchors.fill: parent
        }
        width: parent.width
        height:parent.height-parent.height/2
        border.color: "black"
        anchors.top:screen2.bottom
    }
}
