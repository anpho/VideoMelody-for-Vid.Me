import bb.cascades 1.4
import bb.data 1.0

Page {
    attachedObjects: [
        Common {
            id: co
        },
        QtObject {
            id: ds_search
            function load() {
                var endp = "https://api.vid.me/videos/search";
                var params = [ "query=" + query, "order=" + order ];
                params.push("offset=" + listview_search.offset);
                if (nsfw) {
                    params.push("nsfw=true")
                }
                co.ajax("GET", endp, params, function(b, d) {
                        if (b) {
                            // on data recv
                            d = JSON.parse(d);
                            if (d.status) {
                                results_count = ": " + d.page.total;
                                listview_search.page = d.page;
                                listview_search.offset = d.page.offset + d.page.limit

                                // nsfw filter
                                if (_app.getShowNsfw()) {
                                    dm_search.append(d.videos);
                                } else {
                                    var cleanVideos = [];
                                    for (var i = 0; i < d.videos.length; i ++) {
                                        if (d.videos[i].nsfw) {
                                            continue;
                                        } else {
                                            cleanVideos.push(d.videos[i])
                                        }
                                    }
                                    dm_search.append(cleanVideos);
                                }
                                //

                                listview_search.loading = false;
                            } else {
                                listview_search.loading = false;
                                rootpane.errorToast(qsTr("Error occurred, %1").arg(d.error));
                            }
                        } else {
                            // on error
                            listview_search.loading = false;
                            rootpane.errorToast(qsTr("Server unreachable"))
                            console.log(d)
                        }
                    }, [], true)
            }

        }
    ]
    function setActive() {
        listview_search.scrollRole = ScrollRole.Main
    }
    property string query: ""
    property bool nsfw: false
    property string order: "likes_count"
    property variant nav
    property string results_count: ""
    function doQuery() {
        listview_search.reset();
    }
    titleBar: TitleBar {
        title: qsTr("Search Results %1").arg(results_count)
    }
    actionBarAutoHideBehavior: ActionBarAutoHideBehavior.HideOnScroll
    actionBarVisibility: ChromeVisibility.Compact
    Container {
        verticalAlignment: VerticalAlignment.Fill
        horizontalAlignment: HorizontalAlignment.Fill
        layout: DockLayout {

        }
        ListView {
            id: listview_search
            property int offset: 0
            property variant page
            property bool loading: false
            function reset() {
                offset = 0;
                page = null;
                if (! dm_search.isEmpty()) dm_search.clear();
                loading = true;
                ds_search.load();
            }
            function requestVideoPlayer(title, uri, image) {
                console.log("Playing %1, %2, %3".arg(title).arg(uri).arg(image));
                _app.invokeVideo(title, uri, image);
            }
            function requestShare(uri) {
                _app.shareURL(uri);
            }
            function isShowNSFWCover() {
                return _app.getShowNsfwCOVER();
            }
            function requestOpen(uri) {
                _app.openURL(uri);
            }
            function requestDownload(uri) {
                rootpane.errorToast("Not implemented yet.")
            }
            dataModel: ArrayDataModel {
                id: dm_search
            }
            listItemComponents: ListItemPallette {

            }
            attachedObjects: [
                ListScrollStateHandler {
                    onScrollingChanged: {
                        if (scrolling && atEnd && ! listview_search.loading) {
                            listview_search.loading = true;
                            ds_search.load()
                        }
                    }
                    onAtEndChanged: {
                        if (atEnd && ! listview_search.loading) {
                            listview_search.loading = true;
                            ds_search.load()
                        }
                    }
                }
            ]
            scrollIndicatorMode: ScrollIndicatorMode.ProportionalBar
            layout: StackListLayout {

            }
            bufferedScrollingEnabled: true
            scrollRole: ScrollRole.Main
        }
        ActivityIndicator {
            verticalAlignment: VerticalAlignment.Fill
            horizontalAlignment: HorizontalAlignment.Fill
            running: listview_search.loading
        }
    }
}
