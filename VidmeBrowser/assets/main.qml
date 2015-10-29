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
    showTabsOnActionBar: false
    property variant currentNavpane
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
    Tab {
        title: qsTr("Browse")
        imageSource: "asset:///icon/ic_home.png"
        NavigationPane {
            id: nav_browse
            onPopTransitionEnded: {
                page.destroy();
                if (page.setActive) {
                    page.setActive();
                }
            }
            onPushTransitionEnded: {
                if (page.setActive) {
                    page.setActive();
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
                property bool showloadingTips: false
                Container {
                    layout: DockLayout {

                    }
                    Container {
                        verticalAlignment: VerticalAlignment.Fill
                        horizontalAlignment: HorizontalAlignment.Fill
                        SegmentedControl {
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
                        Container {
                            visible: op_featured.selected
                            onVisibleChanged: {
                                if (visible) {
                                    listview_featured.scrollRole = ScrollRole.Main
                                }
                            }
                            VListView {
                                scrollRole: ScrollRole.Main
                                baseurl: "https://api.vid.me/videos/featured?offset="
                                id: listview_featured
                                onToast: {

                                }
                            }
                            Container {
                                visible: listview_featured.loading
                                layout: DockLayout {
                                }
                                horizontalAlignment: HorizontalAlignment.Fill
                                topPadding: 20.0
                                leftPadding: 20.0
                                rightPadding: 20.0
                                bottomPadding: 20.0
                                Container {
                                    layout: StackLayout {
                                        orientation: LayoutOrientation.LeftToRight

                                    }
                                    horizontalAlignment: HorizontalAlignment.Center
                                    verticalAlignment: VerticalAlignment.Center
                                    ActivityIndicator {
                                        running: true
                                        verticalAlignment: VerticalAlignment.Center
                                    }
                                    Label {
                                        text: qsTr("Loading...")
                                        verticalAlignment: VerticalAlignment.Center
                                    }
                                }

                            }
                        }
                        Container {
                            visible: op_hot.selected
                            onVisibleChanged: {
                                if (visible) {
                                    listview_hot.scrollRole = ScrollRole.Main
                                }
                            }
                            VListView {
                                id: listview_hot
                                baseurl: "https://api.vid.me/videos/hot?offset="
                                onToast: {

                                }
                            }
                            Container {
                                visible: listview_hot.loading
                                layout: DockLayout {
                                }
                                horizontalAlignment: HorizontalAlignment.Fill
                                topPadding: 20.0
                                leftPadding: 20.0
                                rightPadding: 20.0
                                bottomPadding: 20.0
                                Container {
                                    layout: StackLayout {
                                        orientation: LayoutOrientation.LeftToRight

                                    }
                                    horizontalAlignment: HorizontalAlignment.Center
                                    verticalAlignment: VerticalAlignment.Center
                                    ActivityIndicator {
                                        running: true
                                        verticalAlignment: VerticalAlignment.Center
                                    }
                                    Label {
                                        text: qsTr("Loading...")
                                        verticalAlignment: VerticalAlignment.Center
                                    }
                                }

                            }
                        }
                        Container {
                            visible: op_trending.selected
                            onVisibleChanged: {
                                if (visible) {
                                    listview_trending.scrollRole = ScrollRole.Main
                                }
                            }
                            VListView {
                                id: listview_trending
                                baseurl: "https://api.vid.me/videos/trending?offset="
                                onToast: {

                                }
                            }
                            Container {
                                visible: listview_trending.loading
                                layout: DockLayout {
                                }
                                horizontalAlignment: HorizontalAlignment.Fill
                                topPadding: 20.0
                                leftPadding: 20.0
                                rightPadding: 20.0
                                bottomPadding: 20.0
                                Container {
                                    layout: StackLayout {
                                        orientation: LayoutOrientation.LeftToRight

                                    }
                                    horizontalAlignment: HorizontalAlignment.Center
                                    verticalAlignment: VerticalAlignment.Center
                                    ActivityIndicator {
                                        running: true
                                        verticalAlignment: VerticalAlignment.Center
                                    }
                                    Label {
                                        text: qsTr("Loading...")
                                        verticalAlignment: VerticalAlignment.Center
                                    }
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
        id: tab_search
        title: qsTr("Search")
        imageSource: "asset:///icon/ic_search.png"
        NavigationPane {
            id: nav_search
            SearchView {
                nav: nav_search
            }
        }
    }
    Tab {
        title: qsTr("Nearby")
        imageSource: "asset:///icon/ic_map.png"
        enabled: false
        NavigationPane {
            id: nav_nearby
            Page {

            }
        }
    }
}