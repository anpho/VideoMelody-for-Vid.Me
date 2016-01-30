import bb.cascades 1.4
import cn.anpho 1.0
ListItemComponent {
    type: ""
    Container {
        contextActions: [
            ActionSet {
                title: ListItemData.title
                actions: [
                    ActionItem {
                        title: qsTr("Share")
                        onTriggered: {
                            var embed_url = ListItemData.embed_url;
                            itemroot.ListItem.view.requestShare(embed_url);
                        }
                        imageSource: "asset:///icon/ic_share.png"
                    },
                    ActionItem {
                        title: qsTr("Open With...")
                        imageSource: "asset:///icon/ic_forward.png"
                        onTriggered: {
                            var videourl = ListItemData.complete_url
                            itemroot.ListItem.view.requestOpen(videourl);
                        }
                    }
                ]
            }
        ]
        id: itemroot
        function requestDetailsView() {
            itemroot.ListItem.view.requestVideoDetails(JSON.stringify(ListItemData));
        }
        property bool display_details: itemroot.ListItem.view.showCompactView
        topPadding: 10.0
        leftPadding: 10.0
        bottomPadding: 10.0
        rightPadding: 10.0
        topMargin: 20.0
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
                url: ListItemData.user ? ListItemData.user.avatar_url : "asset:///res/vid.png"
                scalingMethod: ScalingMethod.AspectFill
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Left
                preferredHeight: ui.du(8)
                preferredWidth: ui.du(8)
            }
            Label {
                text: ListItemData.user ? ListItemData.user.username : qsTr("Anonymous")
                layoutProperties: StackLayoutProperties {
                    spaceQuota: 5.0
                }
                verticalAlignment: VerticalAlignment.Center
            }
            Container {
                background: Color.Red
                visible: ListItemData.nsfw
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
                    itemroot.ListItem.view.requestVideoPlayer(ListItemData.title, ListItemData.complete_url, ListItemData.thumbnail_url)
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
                url: ListItemData.thumbnail_url
                verticalAlignment: VerticalAlignment.Fill
                horizontalAlignment: HorizontalAlignment.Fill
                visible: ListItemData.nsfw ? itemroot.ListItem.view.isShowNSFWCover() ? false : true : true
            }
            ImageView {
                imageSource: "asset:///res/NSFW.gif"
                scalingMethod: ScalingMethod.AspectFill
                visible: ListItemData.nsfw && itemroot.ListItem.view.isShowNSFWCover()
                verticalAlignment: VerticalAlignment.Fill
                horizontalAlignment: HorizontalAlignment.Fill
            }
        }
        // video area ended.
        // title begin
        Container {
            gestureHandlers: TapHandler {
                onTapped: {
                    itemroot.requestDetailsView();
                }
            }
            Label {
                text: ListItemData.title
                textStyle.fontSize: FontSize.XLarge
                textStyle.fontWeight: FontWeight.W100
                textStyle.textAlign: TextAlign.Left
                multiline: true
            }
            Label {
                text: ListItemData.description ? ListItemData.description : ""
                textStyle.fontWeight: FontWeight.W100
                visible: text.length > 0 && ! itemroot.display_details
                multiline: true
                textFormat: TextFormat.Html
            }
        }
        //title end
        // bottom area
        Container {
            visible: ! itemroot.display_details
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
                    text: parseInt(ListItemData.duration + "") + "s"
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
                    text: ListItemData.comment_count
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
                    text: ListItemData.view_count
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
                    text: ListItemData.likes_count
                    textStyle.fontSize: FontSize.XXSmall
                    textStyle.fontWeight: FontWeight.W100
                    textStyle.textAlign: TextAlign.Center
                    horizontalAlignment: HorizontalAlignment.Fill
                }
            }
        }
        Divider {

        }
    }
}