import Felgo 3.0
import QtQuick 2.0

Item {

    signal useLocation()

    signal searchListings (string searchText, bool addToRecents)

    signal showRecentSearches()

    signal loadNextPage()

    signal toggleFavourite (var listingData)

}
