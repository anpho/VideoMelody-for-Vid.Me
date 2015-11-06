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
                    }
                ]
            }
        ]
        id: itemroot
        property bool display_details: true
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
                text: ListItemData.user ? ListItemData.user.username : ""
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
            WebImageView {
                id: thumbnail
                scalingMethod: ScalingMethod.AspectFill
                loadEffect: ImageViewLoadEffect.FadeZoom
                implicitLayoutAnimationsEnabled: false
                url: ListItemData.thumbnail_url
            }
        }
        // video area ended.
        // title begin
        Container {
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
                visible: text.length > 0
                multiline: true
            }
        }
        //title end
        // bottom area
        Container {
            visible: display_details
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