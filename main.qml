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
    width: 1280
    height: 550
    opacity: 1
    minimumHeight: 510;maximumHeight: 550
    minimumWidth: 620;maximumWidth: 1280
    title: qsTr("Terredit 0.1")
    color: "#606060"


    menuBar: MenuBar {
      Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("&Open heightmap")
                onTriggered: console.log("Open action triggered");
            }
            MenuItem {
                text: qsTr("&Save to XML")
                onTriggered: console.log("Save action triggered");
            }
            MenuItem {
                text: qsTr("&Load from XML")
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
        title: qsTr("")
        width: 144
        height: 303
        anchors.bottom: brushbox.top
        anchors.bottomMargin: -25
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 31
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
            y: 8
            width: 28; height: 25
            anchors.left: parent.left
            anchors.leftMargin: 9
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
            height: 193
            anchors.left: button_newFile.right
            anchors.leftMargin: -28
            anchors.top: btn_zoom.bottom
            anchors.topMargin: 119
            highlightFollowsCurrentItem: true
            snapMode: ListView.SnapToItem
            opacity: 0.9
            clip: false
            visible: true
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
                            effect_obecny.texture = ground_thumbnail.source;
                            effect_obecny2.texture = ground_thumbnail.source;

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
            y: 8
            width: 28; height: 25
            anchors.left: button_newFile.right
            anchors.leftMargin: 13
            onClicked: if(!button_newFile.checked){button_newFile.clicked();button_newFile.checked=true}//NECISTY HACK 2
            iconSource: "icons/images/icons/the_X.png"

        }
        Button {
            property string onetexture:"icons/images/icons/one_texture.png";
            property string tiled:"icons/images/icons/tiles.png";
            property int n: 0
            y: 8

            width: 28; height: 25
            anchors.left: button_newFile.right
            anchors.leftMargin: 54
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
            x: 16; y: 44; width: 97; height: 38
            property int n: 0
//            anchors.horizontalCenter: button_newFile.horizontalCenter
//            anchors.right: button_newFile.right
//            anchors.left: parent.left
//            anchors.top: button_newFile.bottom
            anchors.topMargin: 6
            text: "Zoom type"
            anchors.horizontalCenterOffset: 31
            anchors.leftMargin: 31
            onClicked:viewport.fovzoom ^= 1
            onIconSourceChanged:{n ^= 1;}
            tooltip: "FOV zoom / Camera zoom"

            //property Component btn_delegate: Styles{}

            Slider{
              id: zoom_slider
              width: 114
              height: 35
              anchors.leftMargin: -6
              anchors.left: parent.left; anchors.top: parent.bottom
              anchors.topMargin: 43
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

        Label {
            id: label3
            x: 19
            y: 108
            text: qsTr("Zoom speed")
            font.pointSize: 11
        }

        Label {
            id: label4
            x: 34
            y: 171
            text: qsTr("Textures")
            font.pointSize: 11
        }

        Label {
            id: label5
            x: 1120
            y: 320
            text: qsTr("Terrain settings")
            font.pointSize: 11
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

Rectangle{
    id:viewport_rect
    anchors.left: mainMenuBox.right; anchors.top: mainMenuBox.top
    anchors.leftMargin: 10; anchors.topMargin: 0
    Viewport {
    id: viewport
    //x: mainMenuBox.x+200
    //y: mainMenuBox.y+30
//    anchors.left: mainMenuBox.right; anchors.top: mainMenuBox.top
//    anchors.leftMargin: 30; anchors.topMargin: 30
    width: 450
    height: 450
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
//        property alias fieldOfView: zoom_slider.value
        //fieldOfView: 65
        adjustForAspectRatio: true
        center: Qt.vector3d(0,0,0)
        eye: Qt.vector3d(0, 50, 20); eyeSeparation: 20
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

}//Viewport
}//rectangle

Rectangle{
    id:viewport_rect2
    anchors.left: mainMenuBox.right; anchors.top: mainMenuBox.top
    anchors.leftMargin: 480; anchors.topMargin: 0
    Viewport {
    id: viewport2
    //x: mainMenuBox.x+200
    //y: mainMenuBox.y+30
//    anchors.left: mainMenuBox.right; anchors.top: mainMenuBox.top
//    anchors.leftMargin: 30; anchors.topMargin: 30
    width: 450
    height: 450
    fillColor: "#A0F6FF"
    picking: false
    //GridView

    blending: true //for alpha blending of drawn objects.
    fovzoom: true
    light:Light {
        id:auxillarylight12
        position:  Qt.vector3d(-60,0,0)
        spotDirection: Qt.vector3d(1,0,0)
        spotExponent: 32 //0-128 0 = uniform distribution
        spotAngle: 100 //0-180

        ambientColor:"#FFD191"; //complementary color for the item from other side #91BFFF
        diffuseColor:"white";
        specularColor: "#A0F6FF"; linearAttenuation: 0.001

    }
    camera: Camera {
        id: camera12
//        property alias fieldOfView: zoom_slider.value
        //fieldOfView: 65
        adjustForAspectRatio: true
        center: Qt.vector3d(0,0,0)
        eye: Qt.vector3d(3, 50, 20); eyeSeparation: 20
        projectionType: "Perspective" //or Orthogonal
        upVector: Qt.vector3d(0,0,1)


    }
    Item3D {
        id: scene2
        mesh: Mesh { source: "models/SnowTerrain2.obj" }
        property bool spin: true;
        light:Light {
           id:auxillarylightTerrain2
           position:  Qt.vector3d(60,0,0)
           spotDirection: Qt.vector3d(-1,0,0)
           spotExponent: 32 //0-128 0 = uniform distribution
           spotAngle: 100//0-180

           ambientColor:"#91BFFF"; //complementary color for the item from other side #FFD191
           diffuseColor:"white";
           specularColor: "#A0F6FF"; linearAttenuation: 0.001

       }
        Item {
            id: keyHandler_scene2
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
             id:effect_obecny2
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
                id: scene_rotate12
                angle: 0
                axis: Qt.vector3d(0,0,1)
            }
        ]
        SequentialAnimation{
           running: scene.spin
           NumberAnimation{
               target:scene_rotate12
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

}//Viewport
}//rectangle
//    }
    GroupBox {
            id: brushbox
            x: 0
            y: 373
            width: 144
            height: 95
            anchors.horizontalCenterOffset: 856
            anchors.leftMargin: 1113
            //            anchors.horizontalCenter: mainMenuBox.horizontalCenter
//            anchors.right: mainMenuBox.right
            anchors.left: parent.left
            title: qsTr("")
            ExclusiveGroup{id:brush_mode;}

            Button {
              id: button2
              x: 28
              y: 8
              width: 73
              height: 35
              text: qsTr("Set raster")
            }

            Button {
                id: button3
                x: 28
                y: 49
                width: 73
                height: 35
                text: qsTr("Set cant")
            }


    }

    Slider {
      id: scale_slider
      x: 29
      y: 493
      width: 1211
      height: 25
      value: 0.1
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

        GroupBox {
          id: groupBox1
          x: 1089
          y: 31
          width: 178
          height: 323
          title: qsTr("")

            Slider {
              id: waterLevelSlider
              x: 70
              y: 26
              width: 22
              height: 271
              orientation: Qt.Vertical
              value: 0.2
            }

            Button {
              id: addtreebutton
              x: 6
              y: 232
              width: 65
              height: 65
              activeFocusOnPress: false
              iconSource: "icons/images/icons/tree128.png"
            }

            Button {
              id: addbushbutton
              x: 91
              y: 232
              width: 65
              height: 65
              activeFocusOnPress: false
              iconSource: "icons/images/icons/bush.jpg"
            }

            Button {
              id: addtreebutton1
              x: 6
              y: 144
              width: 65
              height: 65
              activeFocusOnPress: false
              iconSource: "icons/images/icons/tree128.png"
            }

            Button {
              id: addtreebutton2
              x: 6
              y: 56
              width: 65
              height: 65
              activeFocusOnPress: false
              iconSource: "icons/images/icons/tree128.png"
            }

            Button {
              id: addtreebutton3
              x: 91
              y: 144
              width: 65
              height: 65
              activeFocusOnPress: false
              iconSource: "icons/images/icons/tree128.png"
            }

            Button {
                id: addtreebutton4
                x: 91
                y: 56
                width: 65
                height: 65
                activeFocusOnPress: false
                iconSource: "icons/images/icons/tree128.png"
            }
        }

        Label {
            id: label1
            x: 37
            y: 469
            text: qsTr("Scale")
            font.pointSize: 11
            textFormat: Text.PlainText
        }

        Label {
            id: label2
            x: 29
            y: 15
            text: qsTr("3D controls")
            font.pointSize: 11
        }

        Label {
            id: label6
            x: 1091
            y: 31
            text: qsTr("Water level and objects")
            font.pointSize: 11
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
