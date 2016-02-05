/*
* Project: kMediaCenter
* Author:  Keshav Bhatt
* Date:    20.Feb.2015
*
* Copyright (c) 2014, 2015 Keshav Bhatt. All rights reserved.
*
* This file is part of  kMediaCenter.
*
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Code is property of Keshav Bhatt <keshavnrj@gmail.com>, and is part of his project <Kmusicplay>
 * hence , project and its part can not be copied and/or distributed without the express
 * permission of Keshav Bhatt <keshavnrj@gmail.com> .
 */
import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Styles 1.0
import QtGraphicalEffects 1.0

import "base.js" as Base
Slider {
    id : sld
    height : 6


    Layout.fillWidth: true
    width:                    parent.width
    Layout.alignment:         Qt.AlignVCenter | Qt.AlignHCenter

    property int sliderHeight : 7
    property int handleWidth : 15
    property int handleHeight : 15
    property int handleRadius : 10

    style: SliderStyle {
        groove: Rectangle {
            id : theRect
            implicitWidth: sld.width
            implicitHeight: sliderHeight
            color: Base.Color.Disabled.Value
            radius: sliderHeight/2
            RectangularGlow {
                   id: effect3
                   anchors.fill: theRect
                   glowRadius: 5
                   spread: 0.2
                   color: Base.Color.Disabled.Value
                   cornerRadius: theRect.radius + glowRadius
               }

            Rectangle {
                id : completeRect
                 implicitWidth: styleData.handlePosition
                 implicitHeight: sliderHeight
                 color: Base.Color.Primary.Value
                 radius: sliderHeight/2
                Behavior on implicitWidth {
                        PropertyAnimation { duration: 400; easing.type : Easing.OutQuad  }
                    }
            }
            states: [
                State {
                    name: "clickState"
                    when : sld.pressed
                    PropertyChanges { target: completeRect; color: Base.Color.Primary.Light}
                },
                State {
                    name: "hoverState"
                    when : sld.hovered
                    PropertyChanges { target: completeRect; color: Base.Color.Primary.Light}
                    PropertyChanges { target: effect; color:"#DD4814" ; glowRadius: 8}

                }

            ]
            transitions: [
                Transition {
                    to : "clickState"
                    PropertyAnimation { properties: "color"; easing.type: Easing.InOutQuad; duration: 300 }
                },
                Transition {
                    to : "hoverState"
                    PropertyAnimation { properties: "color"; easing.type: Easing.InOutQuad; duration: 300 }
                }
            ]

            RectangularGlow {
                   id: effect
                   anchors.fill: completeRect
                   glowRadius: 5
                   spread: 0.2
                   color: "#DD4814"
                   cornerRadius: completeRect.radius + glowRadius
                   Behavior on glowRadius {
                   NumberAnimation { duration: 550; easing.type: Easing.OutQuad }
                   }

               }
        }
        handle: Rectangle {
            id : handleItem
            anchors.centerIn: parent
            opacity: 0.9
            visible: sld.pressed ? true :false
            color: sld.hovered ? sld.pressed ? Base.Color.Info.Dark : Base.Color.Info.Light : Base.Color.Info.Value
            width: sld.handleWidth
            height: sld.handleHeight
            radius: sld.handleRadius
            MouseArea {   acceptedButtons: Qt.NoButton;anchors.fill: parent }
            states: [
                State {
                    name: "clickState"
                    when : sld.pressed
                    PropertyChanges { target: handleItem; color: Base.Color.Primary.Light}
                },
                State {
                    name: "hoverState"
                    when : sld.hovered
                    PropertyChanges { target: handleItem; color: Base.Color.Primary.Light}
                }

            ]
            transitions: [
                Transition {
                    to : "clickState"
                    PropertyAnimation { properties: "color"; easing.type: Easing.InOutQuad; duration: 300 }
                },
                Transition {
                    to : "hoverState"
                    PropertyAnimation { properties: "color"; easing.type: Easing.InOutQuad; duration: 300 }
                }
            ]
            RectangularGlow {
                   id: effect2
                   anchors.fill: handleItem
                   glowRadius: 5
                   spread: 0.2
                   color: "#DD4814"
                   cornerRadius: handleItem.radius + glowRadius
               }
        }

    }
}
