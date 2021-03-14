import QtQuick 2.0
import QtQuick.Layouts 1.15

Item {
    ColumnLayout{
        anchors.fill: parent

        Rectangle{
            color: "black"
            Layout.fillWidth: true
            implicitHeight: 400

            Image {
                source: Movie.backdrop
                width: parent.width
                height: parent.height
                fillMode: Image.PreserveAspectCrop
                opacity: 0.2
            }

            RowLayout{
                anchors.fill: parent
                anchors.margins: 20

                Rectangle{
                    Layout.fillHeight: true
                    implicitWidth: 300
                    color: "black"
                }

                Item {
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    ColumnLayout {
                        width: parent.width

                        Text{
                            text: Movie.title
                            font.bold: true
                            font.pixelSize: 30
                            color: "white"
                        }

                        Text {
                            text: "02/11/2021 (US) Drama, Thriller 1h 26m"
                            color: "white"
                        }

                        Text{
                            text: "Overview"
                            font.bold: true
                            color: "white"
                        }

                        Text{
                            text: "Movie overview...."
                            color: "white"
                        }
                    }

                }

            }

        }

        Text {
            text: "Top Billed Cast"
            font.pixelSize: 20
            font.bold: true
            Layout.leftMargin: 10
        }

        Rectangle{
            color: "lightgray"
            Layout.fillWidth: true
            implicitHeight: 150
            Layout.margins: 10

            Text {
                text: "Cast list view..."
            }
        }

        Item{Layout.fillHeight: true}

    }
}
