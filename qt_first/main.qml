import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1



ApplicationWindow {
    id: w_root

    visible: true
    width: 800
    height: 600
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
                text: qsTr("E&xit")
                onTriggered: Qt.quit();
            }
        }
    }
    GroupBox {
        id: groupBox1
        title: qsTr("Cool Bro")
        width: 144
        height: 218
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        visible: true

        Button {
            id: button_newFile
            width: 28; height: 25
            checkable: true
            //exclusiveGroup: excl_new_file
            tooltip: "New File button"
            iconSource: "icons/images/icons/new_file.png"
            onClicked: list_textures.visible == true ? list_textures.visible=0: list_textures.visible=1
            }


        ListView {
            id: list_textures
            width: 110
            height: 160
            anchors.left: button_newFile.right
            anchors.leftMargin: -28
            anchors.top: button_newFile.bottom
            anchors.topMargin: 5
            highlightFollowsCurrentItem: true
            snapMode: ListView.NoSnap
            opacity: 0.8
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
                        id: ground
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
                        anchors.fill: ground

                        onClicked:{
                            console.log("test");
                            scene.source=ground.source
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
            x: 34; y: 0
            width: 28; height: 25
            onClicked: if(button_newFile.checked){button_newFile.clicked();button_newFile.checked=false}//NECISTY HACK 2
            iconSource: "icons/images/icons/the_X.png"

        }
        Button {
            property string onetexture:"icons/images/icons/one_texture.png";
            property string tiled:"icons/images/icons/tiles.png";
            property int n: 0
            x: 68; y: 0
            width: 28; height: 25
            //text: "New File"
            iconSource: onetexture
            onClicked: if(n){iconSource=tiled;scene.fillMode=Image.TileHorizontally}
                       else {iconSource=onetexture; scene.fillMode=Image.PreserveAspectFit}
            onIconSourceChanged:{n ^= 1;}

          /*  property string hlp:"icons/images/icons/one_texture.png"
            onClicked: iconSource=hlp; hlp=*/
        }
    }

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
    }
    GroupBox {
            id: groupBox2
            x: 0
            y: 204
            width: 144
            height: 171
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


}
