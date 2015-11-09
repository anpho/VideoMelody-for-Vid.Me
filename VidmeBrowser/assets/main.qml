/*
 * Copyright (c) 2011-2015 BlackBerry Limited.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import bb.cascades 1.4
import bb.data 1.0
import bb.system 1.2
import cn.anpho 1.0
import bb.device 1.4
TabbedPane {
    onCreationCompleted: {
        if (_app.getv("password", "").length > 0) {
            var lock = Qt.createComponent("lock.qml").createObject(rootpane);
            lock.open();
        }
    }
    Menu.definition: MenuDefinition {
        helpAction: HelpActionItem {
            onTriggered: {
                var aboutpage = Qt.createComponent("AboutPage.qml").createObject(currentNavpane);
                currentNavpane.push(aboutpage)
            }
        }
        settingsAction: SettingsActionItem {
            onTriggered: {
                var settingspage = Qt.createComponent("SettingsPage.qml").createObject(currentNavpane);
                currentNavpane.push(settingspage)
            }
        }
        actions: [
            ActionItem {
                title: qsTr("Rate")
                imageSource: "asset:///icon/ic_edit_bookmarks.png"
                onTriggered: {
                    Qt.openUrlExternally("appworld://content/59983323");
                }
            }
        ]
    }
    showTabsOnActionBar: false
    property variant currentNavpane: nav_browse
    id: rootpane
    attachedObjects: [
        SystemToast {
            id: sst
        },
        DisplayInfo {
            id: di
        }
    ]

    function errorToast(msg) {
        sst.body = msg;
        sst.show()
    }
    onActiveTabChanged: {
        currentNavpane = activeTab.tabnav
        if (activeTab.resetNSFW) {
            activeTab.resetNSFW();
        }
    }
    Tab {
        property alias tabnav: nav_browse
        title: qsTr("Browse")
        imageSource: "asset:///icon/ic_home.png"
        NavigationPane {
            id: nav_browse
            onPopTransitionEnded: {
                page.destroy();
                if (page.setActive) {
                    page.setActive();
                }
                if (nav_browse.top == page_browse) {
                    Application.menuEnabled = true
                }
            }
            onPushTransitionEnded: {
                if (page.setActive) {
                    page.setActive();
                }
                if (nav_browse.top != page_browse) {
                    Application.menuEnabled = false
                }
            }
            Page {
                id: page_browse
                actionBarVisibility: ChromeVisibility.Compact
                actionBarAutoHideBehavior: ActionBarAutoHideBehavior.HideOnScroll
                actions: [
                    ActionItem {
                        title: qsTr("Search")
                        imageSource: "asset:///icon/ic_search.png"
                        ActionBar.placement: ActionBarPlacement.Signature
                        onTriggered: {
                            rootpane.activeTab = tab_search
                        }
                    }
                ]
                titleBar: TitleBar {
                    title: qsTr("Home")
                    scrollBehavior: TitleBarScrollBehavior.NonSticky
                    kind: TitleBarKind.Segmented
                    options: [
                        Option {
                            text: qsTr("Featured")
                            id: op_featured
                        },
                        Option {
                            text: qsTr("Hot")
                            id: op_hot
                        },
                        Option {
                            text: qsTr("Trending")
                            id: op_trending
                        }
                    ]
                }
                property bool showloadingTips: listview_featured.loading || listview_hot.loading || listview_trending.loading
                Container {
                    layout: DockLayout {

                    }
                    Container {
                        verticalAlignment: VerticalAlignment.Fill
                        horizontalAlignment: HorizontalAlignment.Fill
                        VListView {
                            visible: op_featured.selected
                            onVisibleChanged: {
                                if (visible) {
                                    listview_featured.scrollRole = ScrollRole.Main
                                } else {
                                    listview_featured.scrollRole = ScrollRole.Default
                                }
                            }
                            baseurl: "https://api.vid.me/videos/featured?offset="
                            id: listview_featured
                            onToast: {

                            }
                        }

                        VListView {
                            visible: op_hot.selected
                            onVisibleChanged: {
                                if (visible) {
                                    listview_hot.scrollRole = ScrollRole.Main
                                } else {
                                    listview_hot.scrollRole = ScrollRole.Default
                                }
                            }
                            id: listview_hot
                            baseurl: "https://api.vid.me/videos/hot?offset="
                            onToast: {

                            }

                        }

                        VListView {
                            id: listview_trending
                            baseurl: "https://api.vid.me/videos/trending?offset="
                            onToast: {

                            }
                            visible: op_trending.selected
                            onVisibleChanged: {
                                if (visible) {
                                    listview_trending.scrollRole = ScrollRole.Main
                                } else {
                                    listview_trending.scrollRole = ScrollRole.Default
                                }
                            }
                        }
                    }
                    ActivityIndicator {
                        running: true
                        verticalAlignment: VerticalAlignment.Fill
                        horizontalAlignment: HorizontalAlignment.Fill
                        visible: page_browse.showloadingTips
                    }
                }
            }
        }
    }
    Tab {
        function resetNSFW() {
            search_view.resetNSFW();
        }
        property alias tabnav: nav_search
        id: tab_search
        title: qsTr("Search")
        imageSource: "asset:///icon/ic_search.png"
        NavigationPane {
            id: nav_search
            onPushTransitionEnded: {
                if (page.setActive) {
                    page.setActive();
                }
                if (nav_search.top != search_view) {
                    Application.menuEnabled = false
                }
            }
            onPopTransitionEnded: {
                page.destroy();
                if (page.setActive) {
                    page.setActive();
                }
                if (nav_search.top == search_view) {
                    Application.menuEnabled = true
                }

            }
            SearchView {
                id: search_view
                nav: nav_search
            }
        }

    }
    Tab {
        property alias tabnav: nav_nearby
        title: qsTr("Nearby")
        imageSource: "asset:///icon/ic_map.png"
        enabled: false
        description: qsTr("Coming Soon")
        NavigationPane {
            id: nav_nearby
            onPushTransitionEnded: {
                if (page.setActive) {
                    page.setActive();
                }
            }
            onPopTransitionEnded: {
                page.destroy();
                if (page.setActive) {
                    page.setActive();
                }
            }
            Page {

            }
        }
    }
}
