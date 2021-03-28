import QtQuick 2.0
import QtQuick.Layouts 1.15
import QtQuick.Controls 1.4


Item {
    implicitWidth: 250

    ColumnLayout{
        anchors.fill: parent

        TextField {
            placeholderText: "Search..."
            Layout.fillWidth: true

            onTextChanged: MovieListProxy.set_filter(text)
        }

        Text{
            text: "Title"
        }

        Text{
            text: "Release date"
        }

        Text{
            text: "Rating"
        }

        Item {Layout.fillHeight: true}
    }
}
