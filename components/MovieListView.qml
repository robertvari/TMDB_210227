import QtQuick 2.0

Item {
    ListView{
        id: movie_list
        clip: true

        anchors.fill: parent
        model: MovieList

        delegate: Rectangle{
            width: movie_list.width
            height: 30

            Text {
                text: movie_item.title
                font.pixelSize: 16
                font.bold: true
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            }
        }
    }
}
