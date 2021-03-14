import QtQuick 2.0
import QtQuick.Layouts 1.15

Item {
    ColumnLayout{
        anchors.fill: parent

        Rectangle{
            color: "lightblue"
            Layout.fillWidth: true
            implicitHeight: 400

            RowLayout{
                anchors.fill: parent
                anchors.margins: 20
            }

        }

        Item{Layout.fillHeight: true}

    }
}
