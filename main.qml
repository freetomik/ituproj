/****************************************************************************
**
** Copyright (C) 2012 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the Qt3D examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Digia Plc and its Subsidiary(-ies) nor the names
**     of its contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

//![1]
//import QtQuick 2.0
import Qt3D 2.0

import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.2


//styles from styles.qml

ApplicationWindow {
    id: w_root

    visible: true
    width: 1024
    height: 768
    opacity: 1
    minimumHeight: 480;maximumHeight: 768
    minimumWidth: 640;maximumWidth: 1024
    title: qsTr("Terredit 0.1")


    menuBar: MenuBar {
      Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("&Open")
                onTriggered: console.log("Open action triggered");
            }
            MenuItem {
                text: qsTr("&Exit")
                onTriggered: Qt.quit();
            }
        }
    }
    GroupBox {
        id: mainMenuBox
        title: qsTr("Cool Bro")
        width: 144
        height: 303
        anchors.bottom: brushbox.top
        anchors.bottomMargin: 6
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        visible: true

        Item {
            id: keyHandler
            focus: true
            Keys.onPressed:{
                if(event.key == Qt.Key_N )
                    console.log("sh1t");
            }
        }

        Button {
            id: button_newFile
            width: 28; height: 25
            anchors.left: parent.left
            anchors.leftMargin: 0
            checkable: true
            //exclusiveGroup: excl_new_file
            tooltip: "New File button"
            iconSource: "icons/images/icons/new_file.png"
            onClicked: list_textures.visible == true ? list_textures.visible=0: list_textures.visible=1            
            }        
        ListView {
            id: list_textures
            x: 0
            y: 62
            width: 110
            height: 160
            anchors.left: button_newFile.right
            anchors.leftMargin: -25
            anchors.top: btn_zoom.bottom
            anchors.topMargin: 70
            highlightFollowsCurrentItem: true
            snapMode: ListView.SnapToItem
            opacity: 0.9
            clip: false
            visible: false
            flickableDirection: Flickable.VerticalFlick
            model: ListModel {
                ListElement {
                    name: "CrackedSoil"
                    texture: "textures_tiled/images/texures/SoilCracked0067_1_S.jpg"
                }

                ListElement {
                    name: "SoilSand"
                    texture: "textures_tiled/images/texures/SoilSand0111_9_S.jpg"
                }

                ListElement {
                    name: "Gravel"
                    texture: "textures_tiled/images/texures/Gravel0097_5_S.jpg"
                }

                ListElement {
                    name: "Grass"
                    texture: "textures_tiled/images/texures/Grass0103_2_S.jpg"
                }

            }
            delegate: Item {
                x: 5
                width: 80
                height: 40
                //width: ListView.view.width; height: 40;

                RowLayout{
                    //anchors.fill: parent
                    Image {
                        id: ground_thumbnail
                        width: 40
                        height: 40
                        source: texture
                       // anchors.left:parent
                        sourceSize.width: 40
                        sourceSize.height: 40
                    }
                    Text {
                        text: name
                        anchors.verticalCenter: parent.verticalCenter
                        font.bold: true
                    }

                    MouseArea {
                        id: mouse_area1
                        z: 1
                        hoverEnabled: false
                        anchors.fill: ground_thumbnail

                        onClicked:{
                            console.log("test");

                        }
                       /* onHoveredChanged: {
                            console.log("hoverChanged")
                        }*/
                    }
                }

            }
        }
        ExclusiveGroup{id: excl_new_file;} //necisty hack 1 / neprosel
        Button {
            y: 0
            width: 28; height: 25
            anchors.left: button_newFile.right
            anchors.leftMargin: 6
            onClicked: if(button_newFile.checked){button_newFile.clicked();button_newFile.checked=false}//NECISTY HACK 2
            iconSource: "icons/images/icons/the_X.png"

        }
        Button {
            property string onetexture:"icons/images/icons/one_texture.png";
            property string tiled:"icons/images/icons/tiles.png";
            property int n: 0
            y: 0

            width: 28; height: 25
            anchors.left: button_newFile.right
            anchors.leftMargin: 40
            //text: "New File"
            iconSource: onetexture
            onClicked: if(n){iconSource=tiled;viewport.camera.projectionType = "Orthographic"}
                       else {iconSource=onetexture; viewport.camera.projectionType = "Perspective"}
            onIconSourceChanged:{n ^= 1;}
            tooltip: "Ortographic / Perspective view"

          /*  property string hlp:"icons/images/icons/one_texture.png"
            onClicked: iconSource=hlp; hlp=*/
        }
        Button {
            id: btn_zoom
            x: 0; width: 56; height: 25
            property int n: 0
            anchors.horizontalCenter: button_newFile.horizontalCenter
            anchors.right: button_newFile.right
            anchors.left: parent.left
            anchors.top: button_newFile.bottom
            anchors.topMargin: 6
            text: "Zoom"
            onClicked:viewport.fovzoom ^= 1
            onIconSourceChanged:{n ^= 1;}
            tooltip: "FOV zoom / Camera zoom"

            //property Component btn_delegate: Styles{}

            Slider{
                id: zoom_slider
                anchors.left: parent.left; anchors.top: parent.bottom
                anchors.topMargin: 10
                //width: 80; height: 20
                stepSize: 1
                orientation: Qt.Horizontal
                value: 65
                maximumValue: 120; minimumValue: 40

                style: SliderStyle {
                        groove: Rectangle {
                            implicitWidth: 100
                            implicitHeight: 10
                            color: "#C1C1C1"
                            radius: 8
                        }
                        handle: Rectangle {
                            anchors.centerIn: parent
                            color: control.pressed ? "white" : "lightgray"
                            border.color: "gray"
                            border.width: 2
                            implicitWidth: 29
                            implicitHeight: 29
                            radius: 11
                        }
                    }
            }

        }
    }

    Rectangle {
        width: 200
        height: 200
        anchors.right: parent.right; anchors.rightMargin: 35
        anchors.top: parent.top; anchors.topMargin: 20

        Rectangle {
            anchors.left: parent.left
            /* adjust rectangle dimension based on text size */
            width: text.width+16; height: text.height+16
            // our border
            border.width: 2;
            border.color: "gray"
            radius: 4; smooth: true
            gradient: Gradient { // background gradient
                GradientStop { position: 0.0; color: "#424242" }
                GradientStop { position: 1.0; color: "black" }
            }
            Text {
                id: text // object id of this text
                color: "white"
                // center the text on parent
                anchors.horizontalCenter:parent.horizontalCenter;
                anchors.verticalCenter:parent.verticalCenter;
                text: "View LMB press + mouse"
            }
        }
    }
/********puvodni_image
    Rectangle {
        id: rectangle1
        x: 150
        y: 50
        width: 470
        height: 410
       color: "#beeef8"
        Image {
            id: scene
            width: 250
            height:250
            fillMode: Image.PreserveAspectFit
            anchors.left: parent.left;anchors.leftMargin: 100
            anchors.top: parent.top;anchors.topMargin: 100
            source: "textures_tiled/images/texures/Grass0103_2_S.jpg"
        }
*/
//Rectangle{
    //id:viewport_rect
    //anchor.left: mainMenuBox.right; anchor.top: mainMenuBox.top
  //  anchor.leftMargin: 30; anchor.topMargin: 30
    Viewport {
    id: viewport
    //x: mainMenuBox.x+200
    //y: mainMenuBox.y+30
    anchors.left: mainMenuBox.right; anchors.top: mainMenuBox.top
    anchors.leftMargin: 30; anchors.topMargin: 30
    width: 600
    height: 500
    fillColor: "#A0F6FF"
    picking: false
    //GridView

    blending: true //for alpha blending of drawn objects.
    fovzoom: true
    light:Light {
        id:auxillarylight1
        position:  Qt.vector3d(-60,0,0)
        spotDirection: Qt.vector3d(1,0,0)
        spotExponent: 32 //0-128 0 = uniform distribution
        spotAngle: 100 //0-180

        ambientColor:"#FFD191"; //complementary color for the item from other side #91BFFF
        diffuseColor:"white";
        specularColor: "#A0F6FF"; linearAttenuation: 0.001

    }
    camera: Camera {
        id: camera1
        property alias fieldOfView: zoom_slider.value
        //fieldOfView: 65
        adjustForAspectRatio: true
        center: Qt.vector3d(0,0,0)
        eye: Qt.vector3d(0, 50, 0); eyeSeparation: 20
        projectionType: "Perspective" //or Orthogonal
        upVector: Qt.vector3d(0,0,1)


    }
    Item3D {
        id: scene
        mesh: Mesh { source: "models/SnowTerrain2.obj" }
        property bool spin: true;
        light:Light {
           id:auxillarylightTerrain
           position:  Qt.vector3d(60,0,0)
           spotDirection: Qt.vector3d(-1,0,0)
           spotExponent: 32 //0-128 0 = uniform distribution
           spotAngle: 100//0-180

           ambientColor:"#91BFFF"; //complementary color for the item from other side #FFD191
           diffuseColor:"white";
           specularColor: "#A0F6FF"; linearAttenuation: 0.001

       }
        Item {
            id: keyHandler_scene
            focus: true
            Keys.onPressed:{
                if(event.key == Qt.Key_R ){
                    console.log("360 noscope");
                    scene.spin= true;
                }
            }
        }
        pretransform: Rotation3D{
            angle:90
            axis: Qt.vector3d(1,0,0)
        }

        effect: Effect {
             id:effect_obecny
             useLighting: true
             decal : false //true if the texture should be combined with color to decal the texture onto the object
                            //false to use the texture directly, combined with the material parameters.

             //textureImage: Image{
             //           id: scene_texture
             //           source:
             //           fillMode: Image.Tile
             //
             //       }
             texture:"/textures_tiled/images/texures/Snow0065_6_S.jpg"


             material: Material
             {


                //default is good for the start
             }
             onTextureImageChanged: gc()
         }

        transform: [
            Rotation3D {
                id: scene_rotate1
                angle: 0
                axis: Qt.vector3d(0,0,1)
            }
        ]
        SequentialAnimation{
           running: scene.spin
           NumberAnimation{
               target:scene_rotate1
               property: "angle"
               to: 360.0
               duration: 3000
               easing.type:"Linear"
           }
           onStopped: scene.spin = false
        }

        ///////////////////////////////////
        //// {List pridanych objektu?} ////
        ////-*Item3D***********Item3D*-////
        ////-**********Item3D*********-////
        ////-***Item3D****************-////
        ///////////////////////////////////
    }

}
//}

//    }
    GroupBox {
            id: brushbox
            x: 0
            y: 309
            width: 144
            height: 171
            anchors.horizontalCenter: mainMenuBox.horizontalCenter
            anchors.right: mainMenuBox.right
            anchors.left: parent.left
            title: qsTr("Group Box")

            Slider {
                id: brush_slider_whole
                x: 90; y: 58; value: 10
                width: 22; height: 90
                orientation: Qt.Vertical
                maximumValue: 20; minimumValue: 1
            }

            Slider {
                id: brush_slider_out
                x: 45; y: 58; value: 10
                width: 22; height: 90
                orientation: Qt.Vertical
                maximumValue: 20; minimumValue: 1
            }

            Slider {
                id: brush_slider_in
                x: 0; y: 58; value: 10
                width: 22; height: 90;
                orientation: Qt.Vertical
                maximumValue: 20; minimumValue: 1
            }
            ExclusiveGroup{id:brush_mode;}
            Button {
                id: brush_btn_whole; x: 0; y: 8
                width: 28; height: 28
                //text: qsTr("Button")
                iconSource: "icons/images/icons/basicTool_whole.png"
                exclusiveGroup: brush_mode
            }

            Button {
                id: brush_btn_out; x: 45; y: 8
                width: 28; height: 28
                //text: qsTr("Button")
                iconSource: "icons/images/icons/basicTool_out.png"
                exclusiveGroup: brush_mode
            }

            Button {
                id: brush_btn_in; x: 90; y: 8
                width: 28; height: 28
                //text: qsTr("Button")
                iconSource: "icons/images/icons/basicTool_in.png"
                exclusiveGroup: brush_mode
            }


        }

   /*Item {
        id: focusSwitch_handler
        focus: true
        Keys.onPressed:{
            if(event.key === event.key === Qt.Key_Control){ //google qt shortcuts with modifiers
                scene.focus=false;
                mainMenuBox.focus=true;

            }
        }
        Keys.onReleased:{
            if(event.key === Qt.Key_Control){
                mainMenuBox.focus=false;
                scene.focus=true;
                }
        }
    }*/

}
