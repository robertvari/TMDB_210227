import QtQuick 2.0
import QtQuick.Layouts 1.15

Item {

    GridView {
        id: grid_view
        clip: true

        anchors.fill: parent
        model: MovieList
        cellWidth: 175
        cellHeight: 363

        delegate: Rectangle {
            color: "white"
            border.color: "lightgray"
            width: grid_view.cellWidth -10
            height: grid_view.cellHeight -10
            radius: 10

            ColumnLayout{
                anchors.fill: parent

                Image{
                    source: movie_item.poster
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    fillMode: Image.PreserveAspectFit
                }

                Item {
                    Layout.fillWidth: true
                    implicitHeight: 100

                    ColumnLayout{
                        anchors.fill: parent
                        anchors.margins: 5

                        Item{implicitHeight: 10}

                        Text {
                            text: movie_item.title
                            font.pixelSize: 16
                            font.bold: true

                            Layout.fillWidth: true
                            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                        }

                        Text{
                            text: movie_item.release_date
                            color: "gray"
                        }

                        Item{Layout.fillHeight: true}
                    }

                    PopularityProgress{
                        x: -8
                        y: -45

                        percentage: movie_item.vote_average
                    }
                }
            }
        }
    }
}
