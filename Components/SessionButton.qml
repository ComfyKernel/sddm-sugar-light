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
import QtQuick.Controls 2.4

Item {
    id: sessionButton
    height: root.font.pointSize * 4
    width: parent.width / 2
    anchors.horizontalCenter: parent.horizontalCenter

    property var selectedSession: selectSession.currentIndex
    property string textConstantSession

    ComboBox {
        anchors.bottom : parent.bottom

        id: selectSession

        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        hoverEnabled: true

        height : root.font.pointSize * 3

        model: sessionModel
        currentIndex: model.lastIndex
        textRole: "name"

        delegate: ItemDelegate {
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            contentItem: Text {
                text: model.name
                font.pointSize: root.font.pointSize * 0.8
                color: selectSession.highlightedIndex === index ? "white" : root.palette.text
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
            highlighted: parent.highlightedIndex === index
            background: Rectangle {
                color: selectSession.highlightedIndex === index ? root.palette.text : "transparent"
                radius: config.RoundCorners || 0
            }
        }

        indicator {
            visible: false
        }

        contentItem: Text {
            id: displayedItem
            text: (config.TranslateSession || (textConstantSession + " :")) + " " + selectSession.currentText
            color: root.palette.text // parent.down ? root.palette.text : parent.hovered ? Qt.lighter(root.palette.text, 1.8) : root.palette.text
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: root.font.pointSize * 0.8
        }

        background: Rectangle {
            color: "transparent"
            border.width: parent.activeFocus ? 2 : 1
            border.color: root.palette.text // parent.visualFocus ? root.palette.text : "transparent"
            radius: config.RoundCorners || 0
            height: root.font.pointSize * 3
        }

        popup: Popup {
            id: popupHandler
            y: parent.height - 1
            width: parent.width
            implicitHeight: contentItem.implicitHeight
            padding: 1

            contentItem: ListView {
                clip: false
                implicitHeight: contentHeight
                model: selectSession.popup.visible ? selectSession.delegateModel : null
                currentIndex: selectSession.highlightedIndex
                ScrollIndicator.vertical: ScrollIndicator { }
            }

            background: Rectangle {
                width: parent.width
                height: parent.height
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                border.width: 1
                border.color: root.palette.text
                radius: config.RoundCorners || 0
            }

            enter: Transition {
                NumberAnimation { property: "opacity"; from: 0; to: 1 }
            }
        }

        states: [
            State {
                name: "pressed"
                when: selectSession.down
                PropertyChanges {
                    target: displayedItem
                    color: Qt.lighter(config.AccentColor, 1.1)
                }
                PropertyChanges {
                    target: selectSession.background
                    border.color: Qt.lighter(config.AccentColor, 1.1)
                }
            },
            /*State {
                name: "hovered"
                when: selectSession.hovered
                PropertyChanges {
                    target: displayedItem
                    color: Qt.lighter(config.AccentColor, 1.3)
                }
                PropertyChanges {
                    target: selectSession.background
                    border.color: Qt.lighter(config.AccentColor, 1.3)
                }
            },*/
            State {
                name: "focused"
                when: selectSession.visualFocus
                PropertyChanges {
                    target: displayedItem
                    color: config.AccentColor
                }
                PropertyChanges {
                    target: selectSession.background
                    border.color: config.AccentColor
                }
            }
        ]

        transitions: [
            Transition {
                PropertyAnimation {
                    properties: "color, border.color"
                    duration: 150
                }
            }
        ]

    }

}
