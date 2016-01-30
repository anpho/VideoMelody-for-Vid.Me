import bb.cascades 1.4
import bb.data 1.0

Container {
    id: listview_root
    // show toast message, this signal is used to pass the toast request outside.
    signal toast(string msg)

    property string video_id
    // base url of data source
    property string baseurl: "https://api.vid.me/video/%1/comments?offset="

    // data offset, see api doc.
    property int offset: 0

    // indicate whether data source is loading
    property bool loading: false

    // for PULL TO REFRESH usage.
    function reset() {
        offset = 0;
        loading = true;
        ds.load();
    }

    attachedObjects: [
        DataSource {
            id: ds
            source: listview_root.baseurl.arg(listview_root.video_id) + listview_root.offset
            remote: true
            type: DataSourceType.Json
            onDataLoaded: {
                if (data.status) {
                    listview_root.offset = data.page.offset + data.page.limit
                    for (var i = 0; i < data.comments.length; i ++) {
                        var currentitem = Qt.createComponent("CommentListComponent.qml").createObject(listview_root);
                        currentitem.data = data.comments[i];
                        listview_root.add(currentitem)
                    }
                } else {
                    toast(qsTr("Error occurred, %1").arg(data.error))
                }
                listview_root.loading = false;
            }
            onError: {
                listview_root.loading = false;
                toast(qsTr("Server unreachable"))
            }
        }
    ]
    horizontalAlignment: HorizontalAlignment.Fill

}
