import QtQuick 2.0
import QtQuick.Layouts 1.15


Item {
    ColumnLayout{
        anchors.fill: parent

        // navbar
        Navbar{
            Layout.fillWidth: true
        }

        RowLayout{
            Layout.fillHeight: true
            Layout.fillWidth: true

            // filter panel
            Rectangle{
                Layout.fillHeight: true
                implicitWidth: 250
                color: "lightblue"

                Text{
                    text: "Filter panel..."
                }
            }

            // grid view
            Rectangle{
                Layout.fillHeight: true
                Layout.fillWidth: true
                color: "lightgreen"

                Text{
                    text: "Grid view"
                }
            }
        }
    }

}
