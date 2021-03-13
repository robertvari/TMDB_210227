import QtQuick 2.0

Item{
    ListModel {
        id: my_list

        ListElement {
            name: "Jim Williams"
            portrait: ""
        }

        ListElement {
            name: "John Brown"
            portrait: ""
        }
        ListElement {
            name: "Bill Smyth"
            portrait: ""
        }
        ListElement {
            name: "Sam Wise"
            portrait: ""
        }
    }

    GridView {
        width: 300; height: 200

        model: my_list
        delegate: Column {
            Image {
                source: Resources.get_image('user.svg')
                width: 50
                height: 50
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Text { text: name; anchors.horizontalCenter: parent.horizontalCenter }
        }
    }
}
