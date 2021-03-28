import QtQuick 2.15
import QtQuick.Layouts 1.15
import "widgets"


Item {
    id: main_layout

    states: [
        State {
            name: "detailsView"
            PropertyChanges {
                target: list_view_item
                visible: false
            }
            PropertyChanges {
                target: movie_details_item
                visible: true
            }
        }
    ]

    ColumnLayout{
        anchors.fill: parent
        spacing: 1

        // navbar
        Navbar{
            Layout.fillWidth: true
        }

        // download progress
        Progressbar{
            Layout.fillWidth: true
            implicitHeight: 5
        }

        MovieDetails{
            id: movie_details_item
            Layout.fillHeight: true
            Layout.fillWidth: true
            visible: false
        }

        Item {
            id: list_view_item
            Layout.fillHeight: true
            Layout.fillWidth: true
            visible: true

            RowLayout {
                anchors.fill: parent
                anchors.margins: 20

                // filter panel
                FilterPanel{
                    Layout.fillHeight: true
                }

                // grid view
                MovieGridView{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
            }
        }

        Rectangle{
            Layout.fillWidth: true
            implicitHeight: 2
            color: "#05B4E3"

            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop { position: 0.0; color: "transparent" }
                GradientStop { position: 0.5; color: "#05B4E3" }
                GradientStop { position: 1.0; color: "transparent" }
            }
        }

        Text{
            text: "Movie count: " + MovieList.movie_count
            font.pixelSize: 16
            color: "#777777"
            Layout.alignment: Qt.AlignHCenter
        }
    }
}
