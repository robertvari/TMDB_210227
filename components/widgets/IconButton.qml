import QtQuick 2.0

Item {
    id: root

    property string icon
    property int size: 30

    implicitHeight: root.size
    implicitWidth: root.size

    signal clicked

    Image {
        id: iconImage
        source: root.icon
        sourceSize: Qt.size(root.size, root.size)
    }

    MouseArea{
        anchors.fill:parent
        onClicked: root.clicked()
        cursorShape: Qt.PointingHandCursor

        onPressed: iconImage.rotation = 90
        onReleased: iconImage.rotation = 0
    }
}
