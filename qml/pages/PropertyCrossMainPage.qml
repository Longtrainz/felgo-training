import Felgo 3.0
import QtQuick 2.0

Page {

    readonly property real contentPadding: dp(Theme.navigationBar.defaultBarItemPadding)
    property alias childNavigationStack: navStack

    useSafeArea:  false

    NavigationStack {
        id: navStack
        leftColumnIndex: 1
        splitView: tablet

        SearchPage { }
    }
}
