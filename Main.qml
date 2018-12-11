//
// This file is part of Sugar Light, a theme for the Simple Display Desktop Manager.
//
// Copyright 2018 Marian Arlt
//
// Sugar Light is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Sugar Light is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Sugar Light. If not, see <https://www.gnu.org/licenses/>.
//

import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0
import "Components"

Pane{
    id: root

    height: config.ScreenHeight
    width: config.ScreenWidth
    padding: config.ScreenPadding || root.padding

    LayoutMirroring.enabled: config.ForceRightToLeft == "true" ? true : Qt.application.layoutDirection === Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    palette.button: "transparent"
    palette.highlight: config.ThemeColor
    palette.text: config.ThemeColor
    palette.buttonText: config.ThemeColor

    font.family: config.Font
    font.pointSize: config.FontSize !== "" ? config.FontSize : parseInt(height / 80)
    focus: true

    Item {
        id: image
        // Layout.fillWidth: true
        // Layout.fillHeight: true

        //Layout.minimumWidth: parent.width
        width: parent.width;
        height: parent.height;

        Image {
            id: background
            source: config.background || config.Background
            anchors.fill: parent
            asynchronous: true
            cache: true
            fillMode: config.ScaleImageCropped == "true" ? Image.PreserveAspectCrop : Image.PreserveAspectFit
            clip: true
            mipmap: true
        }
        MouseArea {
            anchors.fill: parent
            onClicked: parent.forceActiveFocus()
        }
    }

    Rectangle {
        id: form_holder
        width: parent.width / 2.5;
        height: parent.height;

        clip: true

        GaussianBlur {
            id: blur
            width: parent.parent.width
            height: parent.parent.height
            radius: 40
            samples: 20
            source: image
            visible: false
        }

        BrightnessContrast {
            width: parent.parent.width
            height: parent.parent.height
            source: blur
            brightness: 0.7
            contrast: 0.2
        }

        LoginForm {
            anchors.fill: parent
        }
    }
}
