import QtQuick 2.0
import QtQuick.Layouts 1.15
import QtQuick.Controls 1.4
import "widgets"


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

        Item{
            Layout.fillWidth: true
        }

        Text{
            text: "Max Pages: "
            color: "white"
        }

        TextField{
            id: max_pages_field
            implicitWidth: 30
            text: "1"
            validator: RegExpValidator{regExp: /[0-9]{1,3}/}
        }

        IconButton{
            size: 30
            icon: Resources.get_image("refresh.svg")
            onClicked: MovieList.refresh_movie_list(max_pages_field.text)
        }

//        Button {
//            text: "Refresh"
//            onClicked: MovieList.refresh_movie_list(max_pages_field.text)
//        }
    }
}
