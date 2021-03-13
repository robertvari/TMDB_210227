import QtQuick 2.0
import QtQuick.Layouts 1.15

Item {
    ListModel {
        id: my_list

        ListElement {
            title: "Raya and the Last Dragon"
            release_date: "2021-03-03"
            vote_average: 8.6
            poster_path: 'https://image.tmdb.org/t/p/w300/lPsD10PP4rgUGiGR4CCXA6iY0QQ.jpg'
        }

        ListElement {
            title: "Tom & Jerry"
            release_date: "2021-02-11"
            vote_average: 7.7
            poster_path: 'https://image.tmdb.org/t/p/w300/6KErczPBROQty7QoIsaa6wJYXZi.jpg'
        }
        ListElement {
            title: "Coming 2 America"
            release_date: "2021-03-05"
            vote_average: 7.1
            poster_path: 'https://image.tmdb.org/t/p/w300/vt77Xjy3NI1sMOfbO8I3BpdsFbg.jpg'
        }
    }


    GridView {
        id: grid_view

        anchors.fill: parent
        model: my_list
        cellWidth: 175
        cellHeight: 363

        delegate: Rectangle {
            color: "lightgray"
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

                        Text{
                            text: title
                        }

                        Text{
                            text: release_date
                        }

                        Text{
                            text: vote_average
                        }
                    }
                }
            }
        }
    }
}
