import bb.cascades 1.4
import QtMobilitySubset.location 1.2
Page {
    property variant longitude
    property variant latitude
    property string base_url
    attachedObjects: [
        PositionSource {
            id: locationPos
            updateInterval: 1000
            onPositionChanged: {
                longitude = locationPos.position.coordinate.longitude
                latitude = locationPos.position.coordinate.latitude
                base_url = "https://api.vid.me/videos/location?latitude=%1&longitude=%2&offset=".arg(latitude).arg(longitude);
                defaulttext.visible=false;
                location_view.reset();
                locationPos.stop();
            }
        }
    ]
    function setActive() {
        location_view.scrollRole = ScrollRole.Main
    }
    onCreationCompleted: {
        locationPos.start();
    }
    property variant nav
    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        layout: DockLayout {

        }
        Label {
            text: qsTr("Make sure your device's Location Service is enabled.")
            id: defaulttext
            textStyle.textAlign: TextAlign.Center
            textStyle.fontWeight: FontWeight.W100
            textStyle.fontSize: FontSize.Large
            multiline: true
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
        }
        VListView {
            id: location_view
            baseurl: base_url
            onToast: {
            }
            nav: nav
        }
    }
}
