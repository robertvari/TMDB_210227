import QtQuick 2.0

Text {
    id: root
    font.pixelSize: 16
    opacity: 0.5

    property int rotation: 0

    signal clicked

    states: [
        State {
            name: "active"
            PropertyChanges {
                target: root
                opacity: 1
            }
        }
    ]

    Image{
        source: Resources.get_image("arrow.svg")
        width: 16
        height: 16
        opacity: root.opacity
        anchors.left: root.right
        anchors.margins: 10
        rotation: root.rotation
    }

    MouseArea{
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}
