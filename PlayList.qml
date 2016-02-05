import QtQuick 2.0
import Ubuntu.Components.ListItems 1.0 as ListItem
import Ubuntu.Components 1.1
import Qt.labs.folderlistmodel 1.0
import QtQuick.Dialogs 1.0

Rectangle {
    width: parent.width
    height: parent.height/1.2
    id:playlistrect
    Image {
        id: bg
        source: "images/h.png"
        anchors.fill: parent
    }
  anchors.top:parent.top

  //starting playlist
  Rectangle {
      color: "transparent"
      anchors.topMargin: 30
      height: parent.height - 20
      width: parent.width
      ListView {
          clip: true
          anchors.fill: parent
          //z:1000
          width: parent.width
          height: parent.height
          keyNavigationWraps: false

          objectName: "playlistt"
          id: playlist
          highlightFollowsCurrentItem: true

          // start  scrollbars list
          ScrollBar {
              scrollArea: playlist
              height: playlist.height
              width: 6
              anchors.right: playlist.right
          }
          //    end  scrollbars list
          //start adding item to playlist trasition
          add: Transition {id:damnit
                 NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 250}
                 NumberAnimation { property: "scale"; easing.type: Easing.Linear ; from: 0; to: 1.0; duration: 250 }
             }

             addDisplaced: Transition {
                 NumberAnimation { properties: "y"; duration: 250; easing.type: Easing.Linear }
             }

             remove: Transition {
                 NumberAnimation { property: "scale"; from: 1.0; to: 0; duration: 250 }
                 NumberAnimation { property: "opacity"; from: 1.0; to: 0; duration: 250 }
             }

             removeDisplaced: Transition {
                 NumberAnimation { properties: "y"; duration: 250; easing.type: Easing.Linear}
             }

          //end adding item to playlist trasition
          // start listmodel from floderlistmodel
          model: FolderListModel {
              id: folderModel

              showDirs: false
              showOnlyReadable: true
              onFolderChanged: {
                  playlist.update()
              }

              nameFilters: ["*.mp3", "*.oga", "*.ogg", "*.flac", " *.opus", "*.m4a", "*.aac"]
          }

          // end listmodel from floderlistmodel
          delegate: ListItem.Subtitled {
              id: playa
              //playlst scrolling effect code
                                  property int listY: y - playlist.contentY
                                  property real angleZ: (40 * listY) / playlist.height // 0 - 90 degrees
                                  transform: Rotation {
                                      origin.x: width / 2
                                      origin.y: 50
                                      axis {
                                          x: 1
                                          y: 0
                                          z: 0
                                      }
                                      angle: angleZ
                                  }
                                  Binding {
                                      target: playa
                                      property: "angleZ"
                                      value: 0
                                      when: !(playlist.moving || playlist.dragging)
                                  }

                                  Behavior on angleZ {
                                      NumberAnimation {
                                          duration: 150
                                          to: 0
                                      }
                                      enabled: !(playlist.flicking || playlist.dragging)
                                  }
              //end playlst scrolling effect code
              width: parent.width
              height: 35
              iconSource: "images/music.png"
              text: fileName

              //  subText: ""
              MouseArea {
                  anchors.fill: parent
                  drag.target: parent
                  drag.axis: Drag.XAxis
                  onClicked: {
                      playlist.currentIndex = index
                      mediaPlayer.source = folderModel.get(index,
                                                           "fileURL")
                //      playbanner.start()
                  //    playbanner2.start()
                      mediaPlayer.play()

                      // root.title ="lightMusic : " + fileName;
                      mainWindow.title = "lightMusic : " + folderModel.get(
                                  index, "fileName")

                      mediaPlayer.playbackState === MediaPlayer.PlayingState ? playa.state = "current" : playa.state = "not"
                  }
              }

              Binding {
                  target: playa
                  property: "iconSource"
                  value: Qt.resolvedUrl("images/playing.png")
                  when: mediaPlayer.source === folderModel.get(index,
                                                               "fileURL")
                        || mediaPlayer.StoppedState ? true : false
                                                      || mediaPlayer.status
                                                      === MediaPlayer.EndOfMedia
              }

              Binding {

                  target: playa
                  property: "subText"
                  value: " ‣ " + mediaPlayer.metaData.title
                  when: mediaPlayer.source === folderModel.get(index,
                                                               "fileURL")
              }
              Binding {
                  target: playa
                  property: "subText"
                  value: ""
                  when: mediaPlayer.source !== folderModel.get(index,
                                                               "fileURL")
              }

              states: [
                  State {
                      name: "current"
                      when: playlist.isCurrentItem
                            || mediaPlayer.playbackState.isPlaying
                            || mediaPlayer.source === folderModel.get(
                                index, "fileURL"
                                || mediaPlayer.status === MediaPlayer.EndOfMedia)
                      PropertyChanges {
                          target: playa
                          iconSource: "images/playing.png"
                          opacity: 0.9
                          height: 36
                      }
                  },
                  State {
                      name: "not"
                      when: !playlist.isCurrentItem
                            || !mediaPlayer.playbackState.isPlaying
                      PropertyChanges {
                          target: playa
                          iconSource: "images/music.png"
                          height: 33
                      }
                  }
              ]
              state: "not"
          }


          //emd delegate

          //start highlight playing listitem
          highlight: Rectangle {
              id: highlighter
              anchors.fill: playlist.currentItem
              opacity: 0.1

              gradient: Gradient {
                  GradientStop {
                      position: 0.02
                      color: "#85BFCD"
                  }
                  GradientStop {
                      position: 1.00
                      color: "#85BFCD"
                  }
              }
          }
          //end highlight playing listitem



      }
      // End playlist
  }//end playlist wrapper

  /*start Audio chooser file dialog window */
  FileDialog {
      modality: Qt.ApplicationModal
      id: fileDialogAideo
      title: "Choose a folder with Music"
      selectFolder: true
      selectMultiple: true
      onAccepted: {
          folderModel.folder = fileUrl + "/"
          setSetting("mySetting", folderModel.folder);
          playlistEvoker.checked = true
          console.log("Saved to load in next session " + folderModel.folder)

      }

  }
  /*end audio chooser file dialog window */



  //controls below playlist
    Rectangle{

     width: parent.width
     height:parent.height-parent.height/1.250
      anchors.top:playlistrect.bottom
      Image {
          id: bgg
          source: "images/h.png"
          anchors.fill: parent
      }
     // border.color: "black"
      Rectangle{
          anchors {
              margins: units.gu(2)
          }
height: parent.height
color: "red"
border.color: "black"
width: parent.width
      Image {
          id: imgAdd
          source: "images/add.png"
          opacity: mouseAreapppA.pressed
                   && mouseAreapppA.containsMouse ? 0.7 : 1.0
          scale: mouseAreapppA.pressed
                 && mouseAreapppA.containsMouse ? 0.7 : 1.0
          Behavior on scale {
              NumberAnimation {
                  duration: 200
                  easing.type: Easing.OutQuad
              }
          }
          Behavior on opacity {
              NumberAnimation {
                  duration: 30
                  easing.type: Easing.OutQuad
              }
          }

          MouseArea {
              id: mouseAreapppA
              anchors.fill: parent
              onClicked: {
                  fileDialogAideo.open()
              }
          }
      }//end internal rectangle
      }
    }
}
