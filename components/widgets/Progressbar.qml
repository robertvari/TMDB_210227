import QtQuick 2.0

Item {
    id: root
    property int value: MovieList.movie_count
    property int maxValue: MovieList.max_download_count
    visible: MovieList.is_downloading

    Rectangle {
        height: root.height
        width: (root.width / root.maxValue) * root.value
        color: "#05B4E3"
    }
}
