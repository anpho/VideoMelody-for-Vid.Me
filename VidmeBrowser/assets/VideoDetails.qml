import bb.cascades 1.4
import cn.anpho 1.0
Page {
    id: pageroot
    property variant nav
    property variant cached_video_info

    actionBarAutoHideBehavior: ActionBarAutoHideBehavior.HideOnScroll
    actionBarVisibility: ChromeVisibility.Overlay

    // FUNCTIONS
    function loadcomments(){
        comments.reset();
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

    titleBar: TitleBar {
        title: cached_video_info ? cached_video_info.title : ""
        scrollBehavior: TitleBarScrollBehavior.NonSticky
    }
    ScrollView {
        Container {
            contextActions: [
                ActionSet {
                    title: cached_video_info ? cached_video_info.title : ""
                    actions: [
                        ActionItem {
                            title: qsTr("Share")
                            onTriggered: {
                                var embed_url = cached_video_info ? cached_video_info.embed_url : "";
                                if (embed_url.length > 0) {
                                    requestShare(embed_url);
                                }

                            }
                            imageSource: "asset:///icon/ic_share.png"
                        },
                        ActionItem {
                            title: qsTr("Open With...")
                            imageSource: "asset:///icon/ic_forward.png"
                            onTriggered: {
                                var videourl = cached_video_info ? cached_video_info.complete_url : ""
                                if (videourl.length > 0) {
                                    requestOpen(videourl);
                                }
                            }
                        }
                    ]
                }
            ]
            id: itemroot
            topPadding: 10.0
            leftPadding: 10.0
            bottomPadding: 10.0
            rightPadding: 10.0
            // item title begin
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                leftPadding: 10.0
                topPadding: 10.0
                rightPadding: 10.0
                bottomPadding: 10.0
                WebImageView {
                    url: cached_video_info.user ? cached_video_info.user.avatar_url : "asset:///res/vid.png"
                    scalingMethod: ScalingMethod.AspectFill
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Left
                    preferredHeight: ui.du(8)
                    preferredWidth: ui.du(8)
                }
                Label {
                    text: cached_video_info.user ? cached_video_info.user.username : qsTr("Anonymous")
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 5.0
                    }
                    verticalAlignment: VerticalAlignment.Center
                }
                Container {
                    background: Color.Red
                    visible: cached_video_info && cached_video_info.nsfw
                    Label {
                        text: "NSFW"
                        textStyle.color: Color.White
                        verticalAlignment: VerticalAlignment.Center
                        horizontalAlignment: HorizontalAlignment.Center
                    }

                    layout: DockLayout {

                    }
                    topPadding: 10.0
                    leftPadding: 10.0
                    bottomPadding: 10.0
                    rightPadding: 10.0
                }
            }
            // item title end
            // video area begin
            Container {
                gestureHandlers: TapHandler {
                    onTapped: {
                        requestVideoPlayer(cached_video_info.title, cached_video_info.complete_url, cached_video_info.thumbnail_url)
                    }
                }
                topPadding: 10.0
                leftPadding: 10.0
                bottomPadding: 10.0
                rightPadding: 10.0
                attachedObjects: LayoutUpdateHandler {
                    onLayoutFrameChanged: {
                        thumbnail.preferredWidth = layoutFrame.width
                        thumbnail.preferredHeight = layoutFrame.width / 16 * 9
                    }
                }
                horizontalAlignment: HorizontalAlignment.Fill
                implicitLayoutAnimationsEnabled: false
                layout: DockLayout {

                }
                WebImageView {
                    id: thumbnail
                    scalingMethod: ScalingMethod.AspectFill
                    loadEffect: ImageViewLoadEffect.FadeZoom
                    implicitLayoutAnimationsEnabled: false
                    url: cached_video_info.thumbnail_url
                    verticalAlignment: VerticalAlignment.Fill
                    horizontalAlignment: HorizontalAlignment.Fill
                }
            }
            // video area ended.
            // title begin
            Container {
                Label {
                    text: cached_video_info.title
                    textStyle.fontSize: FontSize.XLarge
                    textStyle.fontWeight: FontWeight.W100
                    textStyle.textAlign: TextAlign.Left
                    multiline: true
                }
                Label {
                    text: cached_video_info.description ? cached_video_info.description : ""
                    textStyle.fontWeight: FontWeight.W100
                    visible: text.length > 0
                    multiline: true
                    textFormat: TextFormat.Html
                }
            }
            //title end
            // bottom area
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Container {
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 1.0
                    }
                    topPadding: 10.0
                    leftPadding: 10.0
                    bottomPadding: 10.0
                    rightPadding: 10.0
                    Label {
                        text: qsTr("Duration")
                        textStyle.fontSize: FontSize.XSmall
                        textStyle.fontWeight: FontWeight.W100
                        textStyle.textAlign: TextAlign.Center
                        horizontalAlignment: HorizontalAlignment.Fill
                    }
                    Label {
                        text: parseInt(cached_video_info.duration + "") + "s"
                        textStyle.fontSize: FontSize.XXSmall
                        textStyle.fontWeight: FontWeight.W100
                        textStyle.textAlign: TextAlign.Center
                        horizontalAlignment: HorizontalAlignment.Fill
                    }
                }
                Container {
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 1.0
                    }
                    topPadding: 10.0
                    leftPadding: 10.0
                    bottomPadding: 10.0
                    rightPadding: 10.0
                    Label {
                        text: qsTr("Comments")
                        textStyle.fontSize: FontSize.XSmall
                        textStyle.fontWeight: FontWeight.W100
                        textStyle.textAlign: TextAlign.Center
                        horizontalAlignment: HorizontalAlignment.Fill
                    }
                    Label {
                        text: cached_video_info.comment_count
                        textStyle.fontSize: FontSize.XXSmall
                        textStyle.fontWeight: FontWeight.W100
                        textStyle.textAlign: TextAlign.Center
                        horizontalAlignment: HorizontalAlignment.Fill
                    }
                }
                Container {
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 1.0
                    }
                    topPadding: 10.0
                    leftPadding: 10.0
                    bottomPadding: 10.0
                    rightPadding: 10.0
                    Label {
                        text: qsTr("Viewed")
                        textStyle.fontSize: FontSize.XSmall
                        textStyle.fontWeight: FontWeight.W100
                        textStyle.textAlign: TextAlign.Center
                        horizontalAlignment: HorizontalAlignment.Fill
                    }
                    Label {
                        text: cached_video_info.view_count
                        textStyle.fontSize: FontSize.XXSmall
                        textStyle.fontWeight: FontWeight.W100
                        textStyle.textAlign: TextAlign.Center
                        horizontalAlignment: HorizontalAlignment.Fill
                    }
                }
                Container {
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 1.0
                    }
                    topPadding: 10.0
                    leftPadding: 10.0
                    bottomPadding: 10.0
                    rightPadding: 10.0
                    Label {
                        text: qsTr("Liked")
                        textStyle.fontSize: FontSize.XSmall
                        textStyle.fontWeight: FontWeight.W100
                        textStyle.textAlign: TextAlign.Center
                        horizontalAlignment: HorizontalAlignment.Fill
                    }
                    Label {
                        text: cached_video_info.likes_count
                        textStyle.fontSize: FontSize.XXSmall
                        textStyle.fontWeight: FontWeight.W100
                        textStyle.textAlign: TextAlign.Center
                        horizontalAlignment: HorizontalAlignment.Fill
                    }
                }
            }
            Header {
                subtitle: qsTr("COMMENTS")
            }
            CommentListView {
                video_id: cached_video_info.video_id
                id: comments
            }
        }
    }
}
