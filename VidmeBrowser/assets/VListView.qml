import bb.cascades 1.4
import bb.data 1.0

ListView {
    id: listview_root
    // show toast message, this signal is used to pass the toast request outside.
    signal toast(string msg)

    property variant nav
    // base url of data source
    property string baseurl

    // data offset, see api doc.
    property int offset: 0

    // indicate whether data source is loading
    property bool loading: false

    // for PULL TO REFRESH usage.
    function reset() {
        offset = 0;
        if (! adm.isEmpty()) adm.clear();
        loading = true;
        ds.load();
    }
    leadingVisual: PTR {
        // 下拉刷新的主体
        id: ptr
        loading: loading
        onTriggerRefresh: {
            reset();
        }
        horizontalAlignment: HorizontalAlignment.Fill
    }
    onTouch: {
        ptr.onlistviewTouch(event)
        //  下拉刷新
    }
    // invoke video player
    function requestVideoPlayer(title, uri, image) {
        console.log("Playing %1, %2, %3".arg(title).arg(uri).arg(image));
        _app.invokeVideo(title, uri, image);
    }
    // invoke url share
    function requestShare(uri) {
        _app.shareURL(uri);
    }
    function isShowNSFWCover() {
        return _app.getShowNsfwCOVER();
    }
    function requestOpen(uri) {
        _app.openURL(uri);
    }
    // invoke download
    function requestDownload(uri) {
        toast("Not implemented yet.");
    }
    // show video details
    function requestVideoDetails(videoInfo) {
        var details = Qt.createComponent("VideoDetails.qml").createObject(nav);
        details.cached_video_info =JSON.parse(videoInfo)
        details.loadcomments();
        nav.push(details);
    }
    dataModel: ArrayDataModel {
        id: adm
    }
    onCreationCompleted: {
        // autoload reset() when first load
        reset();
    }
    listItemComponents: ListItemPallette {
    }
    attachedObjects: [
        DataSource {
            id: ds
            source: listview_root.baseurl + listview_root.offset
            remote: true
            type: DataSourceType.Json
            onDataLoaded: {
                if (data.status) {
                    var show_nsfw = _app.getShowNsfw();
                    listview_root.offset = data.page.offset + data.page.limit
                    if (show_nsfw) {
                        adm.append(data.videos);
                    } else {
                        var cleanVideos = [];
                        for (var i = 0; i < data.videos.length; i ++) {
                            if (data.videos[i].nsfw) {
                                continue;
                            } else {
                                cleanVideos.push(data.videos[i])
                            }
                        }
                        adm.append(cleanVideos);
                    }

                    listview_root.loading = false;
                } else {
                    listview_root.loading = false;
                    toast(qsTr("Error occurred, %1").arg(data.error))
                }
            }
            onError: {
                listview_root.loading = false;
                toast(qsTr("Server unreachable"))
            }
        },
        ListScrollStateHandler {
            // when scroll to the end of listview, load next page.
            onScrollingChanged: {
                if (scrolling && atEnd && ! listview_root.loading) {
                    listview_root.loading = true;
                    ds.load()
                }
            }
            onAtEndChanged: {
                if (atEnd && ! listview_root.loading) {
                    listview_root.loading = true;
                    ds.load()
                }
            }
        }
    ]
    scrollIndicatorMode: ScrollIndicatorMode.ProportionalBar
    layout: StackListLayout {

    }
    bufferedScrollingEnabled: true
    horizontalAlignment: HorizontalAlignment.Fill

    property bool showCompactView: _app.getv("compact", "false") == "true"

    gestureHandlers: [
        PinchHandler {
            onPinchEnded: {
                console.log(event.pinchRatio)
                if (event.pinchRatio < 1.0) {
                    showCompactView = true
                } else {
                    showCompactView = false
                }
                _app.setv("compact", showCompactView);
            }
        }
    ]
    leadingVisualSnapThreshold: 1.0
}
