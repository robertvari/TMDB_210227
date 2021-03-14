import QtQuick 2.0
import QtQuick.Layouts 1.15


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

        // navbar
        Navbar{
            Layout.fillWidth: true
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
    }
}
