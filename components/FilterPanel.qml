import QtQuick 2.0
import QtQuick.Layouts 1.15
import QtQuick.Controls 1.4
import "widgets"

Item {
    implicitWidth: 250

    ColumnLayout{
        anchors.fill: parent

        TextField {
            placeholderText: "Search..."
            Layout.fillWidth: true

            onTextChanged: MovieListProxy.set_filter(text)
        }

        FilterButton{
            text: "Title"
            state: MovieListProxy.current_sorting === "title"? "active": null
            onClicked: MovieListProxy.current_sorting = "title"

            rotation: MovieListProxy.current_sorting === "title"? MovieListProxy.sort_ascending? 0:180 : 0
        }

        FilterButton{
            text: "Release date"
            state: MovieListProxy.current_sorting === "release_date"? "active": null
            onClicked: MovieListProxy.current_sorting = "release_date"
            rotation: MovieListProxy.current_sorting === "release_date"? MovieListProxy.sort_ascending? 0:180 : 0
        }

        FilterButton{
            text: "Rating"
            state: MovieListProxy.current_sorting === "vote_average"? "active": null
            onClicked: MovieListProxy.current_sorting = "vote_average"
            rotation: MovieListProxy.current_sorting === "vote_average"? MovieListProxy.sort_ascending? 0:180 : 0
        }

        Item {Layout.fillHeight: true}
    }
}
