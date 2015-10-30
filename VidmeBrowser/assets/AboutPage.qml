import bb.cascades 1.4

Page {
    titleBar: TitleBar {
        title: qsTr("About")
    }
    actionBarAutoHideBehavior: ActionBarAutoHideBehavior.HideOnScroll
    ScrollView {
        scrollRole: ScrollRole.Main
        Container {
            Header {
                title: qsTr("APPLICATION")
            }

            ImageView {
                topMargin: ui.du(5)
                imageSource: "asset:///res/logo_light_bg_powered_by.png"
                scalingMethod: ScalingMethod.AspectFit
                loadEffect: ImageViewLoadEffect.FadeZoom
                preferredWidth: ui.du(30)
                horizontalAlignment: HorizontalAlignment.Center
            }
            Label {
                text: qsTr("This app is built as BlackBerry 10 client for vidme.")
                textStyle.fontWeight: FontWeight.W100
                textStyle.textAlign: TextAlign.Center
                horizontalAlignment: HorizontalAlignment.Fill
            }
            Header {
                title: qsTr("VID.ME")
            }
            Label {
                text: qsTr("<a href='https://vid.me/terms-of-use'>Terms of use</a>")
                textStyle.fontWeight: FontWeight.W100
                textStyle.textAlign: TextAlign.Center
                horizontalAlignment: HorizontalAlignment.Fill
                multiline: true
                textFormat: TextFormat.Html
            }
            Label {
                text: qsTr("<a href='https://vid.me/privacy'>Privacy Policy</a>")
                textStyle.fontWeight: FontWeight.W100
                textStyle.textAlign: TextAlign.Center
                horizontalAlignment: HorizontalAlignment.Fill
                multiline: true
                textFormat: TextFormat.Html
            }
            Label {
                text: qsTr("<a href='https://vid.me/rules'>Community rules</a>")
                textStyle.fontWeight: FontWeight.W100
                textStyle.textAlign: TextAlign.Center
                horizontalAlignment: HorizontalAlignment.Fill
                multiline: true
                textFormat: TextFormat.Html
            }
            Label {
                text: qsTr("<a href='https://vid.me/dmca'>Digital Millennium Copyright Act Procedures</a>")
                textStyle.fontWeight: FontWeight.W100
                textStyle.textAlign: TextAlign.Center
                horizontalAlignment: HorizontalAlignment.Fill
                multiline: true
                textFormat: TextFormat.Html
            }
            Header {
                title: qsTr("DEVELOPERS")
            }

            Label {
                text: qsTr("Merrick Zhang (<a href='http://bbdev.cn'>BBDev.CN</a>)")
                textStyle.fontWeight: FontWeight.W100
                textStyle.textAlign: TextAlign.Center
                horizontalAlignment: HorizontalAlignment.Fill
                multiline: true
                textFormat: TextFormat.Html
            }
            Divider {
                topMargin: ui.du(5)
            }
        }
    }
}
