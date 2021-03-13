import QtQuick 2.0
import QtQuick.Layouts 1.15

Item {
    ListModel {
        id: my_list

        ListElement {
            title: "Raya and the Last Dragon"
            release_date: "2021-03-03"
            vote_average: 86
            poster_path: 'https://image.tmdb.org/t/p/w300/lPsD10PP4rgUGiGR4CCXA6iY0QQ.jpg'
        }

        ListElement {
            title: "Tom & Jerry"
            release_date: "2021-02-11"
            vote_average: 77
            poster_path: 'https://image.tmdb.org/t/p/w300/6KErczPBROQty7QoIsaa6wJYXZi.jpg'
        }
        ListElement {
            title: "Coming 2 America"
            release_date: "2021-03-05"
            vote_average: 71
            poster_path: 'https://image.tmdb.org/t/p/w300/vt77Xjy3NI1sMOfbO8I3BpdsFbg.jpg'
        }
    }


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
                    source: Resources.get_image("poster.jpg")
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
