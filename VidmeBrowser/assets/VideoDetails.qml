import bb.cascades 1.4
import cn.anpho 1.0
Page {
    id: pageroot
    actionBarAutoHideBehavior: ActionBarAutoHideBehavior.HideOnScroll
    actionBarVisibility: ChromeVisibility.Overlay
    titleBar: TitleBar {
        title: videoinfo.title
    }
    property variant nav
    property string base_url: "https://api.vid.me/videoByUrl/"
    property variant videoinfo: {
        video_id: "",
        url: "",
        "full_url": "",
        "embed_url": "",
        "complete_url": "",
        "title": "",
        "description": null,
        "duration": 0,
        "comment_count": 0,
        "view_count": 0,
        "version": 0,
        "nsfw": false,
        "thumbnail_url": null,
        "score": 0
    }
    property string videourl

    ScrollView {

    }
}
