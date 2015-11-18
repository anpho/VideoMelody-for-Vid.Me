import bb.cascades 1.4

Container {
    layout: DockLayout {

    }
    background: Color.create("#ff1e1e1e")
    topPadding: 40.0
    leftPadding: 40.0
    rightPadding: 40.0
    bottomPadding: 40.0
    ImageView {
        imageSource: "asset:///res/vid.png"
        scalingMethod: ScalingMethod.AspectFit
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Center
    }
}
