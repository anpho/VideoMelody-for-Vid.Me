import bb.cascades 1.4

Container {
    topPadding: 10.0
    leftPadding: 10.0
    rightPadding: 10.0
    bottomPadding: 10.0
    property variant data

    Label {
        text: data? data.user.username:"" + ":"
        textFormat: TextFormat.Plain
        textStyle.fontWeight: FontWeight.W100
        textStyle.fontSize: FontSize.Medium
    }
    Divider {
        
    }
    Container {
        background: Color.create("#32808080")
        horizontalAlignment: HorizontalAlignment.Fill
        Label {
            text:data? data.body:""
            multiline: true
            textFormat: TextFormat.Auto
            textStyle.fontWeight: FontWeight.W100
            textStyle.fontSize: FontSize.Small
        }
    }
    Divider {

    }
}
