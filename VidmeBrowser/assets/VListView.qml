import bb.cascades 1.4
import bb.data 1.0

ListView {
    id: listview_root
    // show toast message, this signal is used to pass the toast request outside.
    signal toast(string msg)
    
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
    
    // invoke video player
    function requestVideoPlayer(title, uri, image) {
        console.log("Playing %1, %2, %3".arg(title).arg(uri).arg(image));
        _app.invokeVideo(title, uri, image);
    }
    // invoke url share
    function requestShare(uri) {
        _app.shareURL(uri);
    }
    // invoke download
    function requestDownload(uri) {
        toast("Not implemented yet.");
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
                    listview_root.offset = data.page.offset + data.page.limit
                    adm.append(data.videos);
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
}
