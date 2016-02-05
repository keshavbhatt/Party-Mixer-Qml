import QtQuick 2.0
import Ubuntu.Components 1.1
import QtMultimedia 5.0
import Kpm 1.0
/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "kpm.keshavnrj"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: true

    // Removes the old toolbar and enables new features of the new header.
    useDeprecatedToolbar: false

    width: units.gu(100)
    height: units.gu(75)
id:mainView



    Page {
        title: i18n.tr("kparty-mixer")



        Grid {
            height: parent.height
            width: parent.width
            columns: 3
            spacing: 2
            Rectangle {  width: parent.width/4; height: parent.height
            MediaPlayer1{
                height: parent.height
            }
            }
            Rectangle {   width: parent.width/2; height: parent.height
            PlayList{
             }
            }
            Rectangle {   width: parent.width/4; height:parent.height
                MediaPlayer2{
                    height: parent.height
                }
            }
       }
}

}





