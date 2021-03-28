import QtQuick 2.0
import QtQuick.Layouts 1.15

Item {
    id: root

    property int titleSize: 30
    property int textSize: 16

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

                Image{
                    source: Movie.poster
                    Layout.fillHeight: true
                    opacity: 1

                    fillMode: Image.PreserveAspectFit
                }

                Item {
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    ColumnLayout {
                        width: parent.width

                        Text{
                            text: Movie.title
                            font.bold: true
                            font.pixelSize: root.titleSize
                            color: "white"

                            Layout.fillWidth: true
                            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                        }

                        Text {
                            text: Movie.release_date + " (" + Movie.language + ") " + Movie.genres +" " + Movie.runtime
                            color: "white"
                            font.pixelSize: root.textSize

                            Layout.fillWidth: true
                            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                        }

                        Item{implicitHeight: 30}

                        Text{
                            text: Movie.tagline
                            color: "white"
                            font.pixelSize: root.textSize

                            Layout.fillWidth: true
                            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                        }

                        Item{implicitHeight: 10}

                        Text{
                            text: "Overview"
                            font.bold: true
                            color: "white"
                            font.pixelSize: root.textSize
                        }

                        Text{
                            text: Movie.overview
                            color: "white"
                            font.pixelSize: root.textSize

                            Layout.fillWidth: true
                            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
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
