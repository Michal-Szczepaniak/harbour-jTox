import QtQuick 2.0
import Sailfish.Silica 1.0

ListItem {
    id: mainItem
    anchors {
        left: parent.left
        right: parent.right
    }

    contentHeight: Math.max(nameLabel.height + smText.height + Theme.paddingSmall*2, 64)

    onClicked: {
        appWindow.activeFriendID = friend_id
        eventmodel.setFriend(friend_id)
        pageStack.push(Qt.resolvedUrl("../pages/Messages.qml"), { friend_id: friend_id })
    }

    menu: ContextMenu {
        id: removeMenu

        MenuItem {
            text: qsTr("Remove")
            onClicked: removeRemorse.execute(mainItem, qsTr("Removing") + " " + name, function() {
                friendmodel.removeFriend(friend_id)
            })
        }

        MenuItem {
            text: qsTr("Details")
            onClicked: {
                friendmodel.setActiveFriendID(friend_id)
                pageStack.push(detailsDialog)
            }
        }
    }

    RemorseItem {
        id: removeRemorse
    }

    Avatar {
        id: avatarIcon

        anchors {
            left: parent.left
            top: parent.top
            leftMargin: Theme.paddingLarge
            topMargin: Theme.paddingSmall
        }

        placeholder: ""
        width: parent.width / 8
        height: width
        source_id: friend_id
    }

    Label {
        id: nameLabel
        anchors {
            left: avatarIcon.right
            right: parent.right
            top: parent.top
            leftMargin: Theme.paddingSmall
            rightMargin: Theme.paddingLarge
            topMargin: Theme.paddingSmall
        }

        text: name
        font.bold: unviewed
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        width: page.width - 64 - Theme.paddingSmall
        font.pixelSize: Theme.fontSizeSmall
    }

    Text {
        id: smText
        color: Theme.highlightColor
        anchors {
            left: avatarIcon.right
            bottom: parent.bottom
            right: usi.left
            leftMargin: Theme.paddingLarge
            rightMargin: Theme.paddingLarge
            bottomMargin: Theme.paddingSmall
        }
        text: status_message
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        font.pixelSize: Theme.fontSizeTiny
    }


    UserTypingIndicator {
        anchors {
            right: parent.right
            bottom: parent.bottom
        }

        visible: typing
    }

    UserStatusIndicator {
        id: usi
        userStatus: status

        anchors {
            right: parent.right
            rightMargin: Theme.paddingLarge
            verticalCenter: parent.verticalCenter
        }
    }
}
