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
