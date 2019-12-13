import Felgo 3.0
import QtQuick 2.0

Page {

    id: searchPage
    title: qsTr("Property Cross")

    rightBarItem: NavigationBarRow {
        ActivityIndicatorBarItem {
            visible: true
        }

        IconButtonBarItem {
            icon: IconType.heart
            title: qsTr("Favourites")
            onClicked: showListings(true)
        }
    }

    Column {
        id: contentCol
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: contentPadding
        spacing: contentPadding

        AppText {
            width: parent.width
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: sp(12)
            text: qsTr("Use the form below to search for houses to buy. You can search by place name, postcode or click 'My location'. ")
        }

        AppText {
            width: parent.width
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: sp(12)
            color: Theme.secondaryTextColor
            font.italic: true
            text: qsTr("You can quickly find something by typing 'London'...")
        }

        AppTextField {
            id: searchInput
            width: parent.width
            showClearButton: true
            placeholderText: qsTr("Search...")
            inputMethodHints: Qt.ImhNoPredictiveText

            onTextChanged: showRecentSearches()
            onEditingFinished: if(navigationStack.currentPage === searchPage) search()
        }

        Row {
            spacing: contentPadding

            AppButton {
                text: qsTr("Go")
                onClicked: search()
            }

            AppButton {
                id: locationButton
                text: qsTr("Get my location")
                enabled: true
                onClicked: {
                    searchInput.text = ""
                    searchInput.placeholderText = "Looking for location..."
                    locationButton.enabled = false
                }
            }
        }
    }

    Component {
        id: listPageComponent
        ListingsListPage {}
    }

    function showRecentSearches () {
        console.log(searchInput.text)
    }

    function search () {
      logic.searchListings(searchInput.text, true)
    }

    function showListings (favorites) {
        if (navigationStack.depth === 1) {
              navigationStack.popAllExceptFirstAndPush(listPageComponent, { favorites: favorites })
        }
    }

    Connections {
        target: dataModel
        onListingsReceived: showListings(false)
        onLocationReceived: if (searchInput.placeholderText === "Looking for location...")
                                searchInput.placeholderText = "Search..."
    }
}


















