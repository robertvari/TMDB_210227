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
            id: card_background
            color: "white"
            border.color: "lightgray"
            width: grid_view.cellWidth -10
            height: grid_view.cellHeight -10
            radius: 10

            states: [
                State {
                    name: "active"

                    PropertyChanges {
                        target: card_background
                        color: Qt.rgba(0, 0, 0, 0.1)
                    }

                    PropertyChanges {
                        target: poster
                        opacity: 0.8
                    }

                    PropertyChanges {
                        target: movie_title
                        color: "#01b4e4"
                    }
                }
            ]

            ColumnLayout{
                anchors.fill: parent

                Image{
                    id: poster
                    source: movie_item.poster
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    opacity: 1

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
                            id: movie_title
                            text: movie_item.title
                            font.pixelSize: 16
                            font.bold: true
                            color: "black"

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

            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true

                onEntered: card_background.state = "active"
                onExited: card_background.state = null

                onClicked: main_layout.state = "detailsView"
            }
        }
    }
}
