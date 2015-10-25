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
                            // listview section
                            ListView {
                                id: listview_featured
                                property int offset: 0
                                property variant page
                                property bool loading: false
                                function reset() {
                                    offset = 0;
                                    page = null;
                                    if (! adm_featured.isEmpty()) adm_featured.clear();
                                    loading = true;
                                    ds_featured.load();
                                }
                                function requestVideoPlayer(title, uri, image) {
                                    console.log("Playing %1, %2, %3".arg(title).arg(uri).arg(image));
                                    _app.invokeVideo(title, uri, image);
                                }
                                function requestShare(uri) {
                                    _app.shareURL(uri);
                                }
                                function requestDownload(uri) {
                                    rootpane.errorToast("Not implemented yet.")
                                }
                                dataModel: ArrayDataModel {
                                    id: adm_featured
                                }
                                onCreationCompleted: {
                                    reset();
                                }
                                listItemComponents: ListItemPallette {

                                }
                                attachedObjects: [
                                    DataSource {
                                        id: ds_featured
                                        source: "https://api.vid.me/videos/featured?offset=" + listview_featured.offset
                                        remote: true
                                        type: DataSourceType.Json
                                        onDataLoaded: {
                                            if (data.status) {
                                                listview_featured.page = data.page;
                                                listview_featured.offset = data.page.offset + data.page.limit
                                                adm_featured.append(data.videos);
                                                listview_featured.loading = false;
                                            } else {
                                                listview_featured.loading = false;
                                                rootpane.errorToast(qsTr("Error occurred, %1").arg(data.error))
                                            }
                                        }
                                        onError: {
                                            listview_featured.loading = false;
                                            rootpane.errorToast(qsTr("Server unreachable"))
                                        }
                                    },
                                    ListScrollStateHandler {
                                        onScrollingChanged: {
                                            if (scrolling && atEnd && ! listview_featured.loading) {
                                                listview_featured.loading = true;
                                                ds_featured.load()
                                            }
                                        }
                                        onAtEndChanged: {
                                            if (atEnd && ! listview_featured.loading) {
                                                listview_featured.loading = true;
                                                ds_featured.load()
                                            }
                                        }
                                    }
                                ]
                                scrollIndicatorMode: ScrollIndicatorMode.ProportionalBar
                                layout: StackListLayout {

                                }
                                bufferedScrollingEnabled: true
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
                            // listview section
                            ListView {
                                id: listview_hot
                                property int offset: 0
                                property variant page
                                property bool loading: false
                                function reset() {
                                    offset = 0;
                                    page = null;
                                    if (! adm_hot.isEmpty()) adm_hot.clear();
                                    loading = true;
                                    ds_hot.load();
                                }
                                function requestVideoPlayer(title, uri, image) {
                                    console.log("Playing %1, %2, %3".arg(title).arg(uri).arg(image));
                                    _app.invokeVideo(title, uri, image);
                                }
                                function requestShare(uri) {
                                    _app.shareURL(uri);
                                }
                                function requestDownload(uri) {
                                    rootpane.errorToast("Not implemented yet.")
                                }
                                dataModel: ArrayDataModel {
                                    id: adm_hot
                                }
                                onCreationCompleted: {
                                    reset();
                                }
                                listItemComponents: ListItemPallette {

                                }
                                attachedObjects: [
                                    DataSource {
                                        id: ds_hot
                                        source: "https://api.vid.me/videos/hot?offset=" + listview_hot.offset
                                        remote: true
                                        type: DataSourceType.Json
                                        onDataLoaded: {
                                            if (data.status) {
                                                listview_hot.page = data.page;
                                                listview_hot.offset = data.page.offset + data.page.limit
                                                adm_hot.append(data.videos);
                                                listview_hot.loading = false;
                                            } else {
                                                listview_hot.loading = false;
                                                rootpane.errorToast(qsTr("Error occurred, %1").arg(data.error))
                                            }
                                        }
                                        onError: {
                                            listview_hot.loading = false;
                                            rootpane.errorToast(qsTr("Server unreachable"))
                                        }
                                    },
                                    ListScrollStateHandler {
                                        onScrollingChanged: {
                                            if (scrolling && atEnd && ! listview_hot.loading) {
                                                listview_hot.loading = true;
                                                ds_hot.load()
                                            }
                                        }
                                        onAtEndChanged: {
                                            if (atEnd && ! listview_hot.loading) {
                                                listview_hot.loading = true;
                                                ds_hot.load()
                                            }
                                        }
                                    }
                                ]
                                scrollIndicatorMode: ScrollIndicatorMode.ProportionalBar
                                layout: StackListLayout {

                                }
                                bufferedScrollingEnabled: true
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
                            // listview section
                            ListView {
                                id: listview_trending
                                property int offset: 0
                                property variant page
                                property bool loading: false
                                function reset() {
                                    offset = 0;
                                    page = null;
                                    if (! adm_trending.isEmpty()) adm_trending.clear();
                                    loading = true;
                                    ds_trending.load();
                                }
                                function requestVideoPlayer(title, uri, image) {
                                    console.log("Playing %1, %2, %3".arg(title).arg(uri).arg(image));
                                    _app.invokeVideo(title, uri, image);
                                }
                                function requestShare(uri) {
                                    _app.shareURL(uri);
                                }
                                function requestDownload(uri) {
                                    rootpane.errorToast("Not implemented yet.")
                                }
                                dataModel: ArrayDataModel {
                                    id: adm_trending
                                }
                                onCreationCompleted: {
                                    reset();
                                }
                                listItemComponents: ListItemPallette {

                                }
                                attachedObjects: [
                                    DataSource {
                                        id: ds_trending
                                        source: "https://api.vid.me/videos/trending?offset=" + listview_trending.offset
                                        remote: true
                                        type: DataSourceType.Json
                                        onDataLoaded: {
                                            if (data.status) {
                                                listview_trending.page = data.page;
                                                listview_trending.offset = data.page.offset + data.page.limit
                                                adm_trending.append(data.videos);
                                                listview_trending.loading = false;
                                            } else {
                                                listview_trending.loading = false;
                                                rootpane.errorToast(qsTr("Error occurred, %1").arg(data.error))
                                            }
                                        }
                                        onError: {
                                            listview_trending.loading = false;
                                            rootpane.errorToast(qsTr("Server unreachable"))
                                        }
                                    },
                                    ListScrollStateHandler {
                                        onScrollingChanged: {
                                            if (scrolling && atEnd && ! listview_trending.loading) {
                                                listview_trending.loading = true;
                                                ds_trending.load()
                                            }
                                        }
                                        onAtEndChanged: {
                                            if (atEnd && ! listview_trending.loading) {
                                                listview_trending.loading = true;
                                                ds_trending.load()
                                            }
                                        }
                                    }
                                ]
                                scrollIndicatorMode: ScrollIndicatorMode.ProportionalBar
                                layout: StackListLayout {

                                }
                                bufferedScrollingEnabled: true
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
