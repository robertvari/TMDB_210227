import QtQuick 2.0
import QtQuick.Layouts 1.15

Rectangle{
    implicitHeight: 64
    color: "#032541"

    RowLayout{
        anchors.fill: parent
        anchors.margins: 10

        Image {
            id: logo
            source: Resources.get_image("logo.svg")

            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: main_layout.state = null
            }
        }

        Text{
            text: "Movie count: " + MovieList.movie_count
            font.pixelSize: 30
            color: "white"
            Layout.alignment: Qt.AlignRight
        }
    }
}
