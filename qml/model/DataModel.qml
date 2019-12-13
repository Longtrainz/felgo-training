import Felgo 3.0
import QtQuick 2.0

Item {

    property alias dispatcher: logicConnection.target

    signal listingsReceived

    Client {
        id: client
    }

    Connections {
        id: logicConnection

        onSearchListings: {
            console.debug("signal searchListings works!")
            client.search(searchText, _.responseCallback)
        }
    }

    Item {
        id: _

        readonly property var successCodes: ["100", "101", "110"]
        readonly property var ambiguousCodes: ["200", "202"]
        property var locations: []
        property var listings: []
        property int numTotalListings
        property int сurrentPage: 1

        function responseCallback (obj) {
            var response = obj.response
            var code = response.application_response_code
            console.debug("Server returned: ", code)

            if (successCodes.indexOf(code) >= 0) {
                // found locations
                сurrentPage = parseInt(response.page)
                listings.concat(response.listings)
                numTotalListings = response.total_results || 0
                listingsReceived()
            } else if (ambiguousCodes.indexOf(code) >= 0) {
                locations = response.locations
            } else if (code === 210) {
                locations = []
            } else {
               locations = []
            }
        }
    }
}
