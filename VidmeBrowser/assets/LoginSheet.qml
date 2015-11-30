import bb.cascades 1.4

Sheet {
    id: sheetroot
    Page {
        titleBar: TitleBar {
            title: qsTr("Login")
            dismissAction: ActionItem {
                title: qsTr("Back")

            }
            acceptAction: ActionItem {
                title: qsTr("Register")

            }
            scrollBehavior: TitleBarScrollBehavior.Sticky
        }
        Container {
            layout: DockLayout {
                
            }
            Container {
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Center
                ImageView {
                    imageSource: "asset:///res/logo_light_bg.png"
                    scalingMethod: ScalingMethod.AspectFit
                    preferredHeight: ui.du(12)
                }
            }
        }
    }
}