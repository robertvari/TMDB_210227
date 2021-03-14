import QtQuick 2.0
import QtQuick.Layouts 1.15


Item {
    states: [
        State {
            name: "listView"
            PropertyChanges {
                target: list_layout
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
