import bb.cascades 1.4
import cn.anpho 1.0
import bb.system 1.2
Page {
    function setActive(){
        scrview.scrollRole = ScrollRole.Main
    }
    attachedObjects: [
        SystemToast {
            id: settings_toast
        }
    ]
    titleBar: TitleBar {
        title: qsTr("Settings")

    }
    ScrollView {
        id: scrview
        Container {
            Header {
                title: qsTr("APPLICATION THEME")
            }
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight

                }
                topPadding: 20.0
                leftPadding: 40.0
                rightPadding: 40.0
                bottomPadding: 20.0
                Label {
                    text: qsTr("Use Dark Theme")
                    verticalAlignment: VerticalAlignment.Center
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 1.0
                    }
                }
                ToggleButton {
                    checked: Application.themeSupport.theme.colorTheme.style === VisualStyle.Dark
                    onCheckedChanged: {
                        checked ? _app.setv("use_dark_theme", "dark") : _app.setv("use_dark_theme", "bright")
                        try {
                            Application.themeSupport.setVisualStyle(checked ? VisualStyle.Dark : VisualStyle.Bright);
                        } catch (e) {
                        }
                    }
                }
            }
            Container {
                leftPadding: 40.0
                rightPadding: 40.0
                bottomPadding: 20.0
                Label {
                    multiline: true
                    text: qsTr("Turn this on to save battery on OLED screen devices.")
                    textStyle.fontWeight: FontWeight.W100
                    textStyle.fontSize: FontSize.XSmall

                }
            }
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight

                }
                topPadding: 20.0
                leftPadding: 40.0
                rightPadding: 40.0
                bottomPadding: 20.0
                Label {
                    text: qsTr("Show Compact View")
                    verticalAlignment: VerticalAlignment.Center
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 1.0
                    }
                }
                ToggleButton {
                    checked: _app.getv("compact", "false") == "true"
                    onCheckedChanged: {
                        _app.setv("compact", checked)
                    }
                }
            }
            Container {
                leftPadding: 40.0
                rightPadding: 40.0
                bottomPadding: 20.0
                Label {
                    multiline: true
                    text: qsTr("This will hide the statistics of each video.")
                    textStyle.fontWeight: FontWeight.W100
                    textStyle.fontSize: FontSize.XSmall

                }
            }
            Header {
                title: qsTr("NSFW CONTENT FILTER")
            }

            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight

                }
                topPadding: 20.0
                leftPadding: 40.0
                rightPadding: 40.0
                bottomPadding: 20.0
                Label {
                    text: qsTr("Show NSFW Content")
                    verticalAlignment: VerticalAlignment.Center
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 1.0
                    }
                }
                ToggleButton {
                    id: toggle_shownsfw
                    checked: _app.getShowNsfw()
                    onCheckedChanged: {
                        _app.setShowNsfw(checked)
                    }
                }
            }
            Container {
                leftPadding: 40.0
                rightPadding: 40.0
                bottomPadding: 20.0
                Label {
                    multiline: true
                    text: qsTr("Because vidme is a user-generated-content service, it may bring in NSFW ( Not Safe For Work ) contents as well. Keep this switch off if you want a safer enviroment.")
                    textStyle.fontWeight: FontWeight.W100
                    textStyle.fontSize: FontSize.XSmall
                }
                Label {
                    text: qsTr("*App restart is required.")
                    textStyle.fontWeight: FontWeight.W100
                    textStyle.fontSize: FontSize.XSmall
                    textStyle.color: Color.create("#ff0082aa")
                }

            }
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight

                }
                topPadding: 20.0
                leftPadding: 40.0
                rightPadding: 40.0
                bottomPadding: 20.0
                Label {
                    text: qsTr("Use NSFW Cover")
                    verticalAlignment: VerticalAlignment.Center
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 1.0
                    }
                }
                ToggleButton {
                    checked: _app.getShowNsfwCOVER()
                    onCheckedChanged: {
                        _app.setShowNsfwCOVER(checked);
                    }
                }

            }
            Container {
                leftPadding: 40.0
                rightPadding: 40.0
                bottomPadding: 20.0
                Label {
                    multiline: true
                    text: qsTr("Replace NSFW video preview with a WARNING image.")
                    textStyle.fontWeight: FontWeight.W100
                    textStyle.fontSize: FontSize.XSmall
                }
                Label {
                    text: qsTr("*App restart is required.")
                    textStyle.fontWeight: FontWeight.W100
                    textStyle.fontSize: FontSize.XSmall
                    textStyle.color: Color.create("#ff0082aa")
                }
                Label {
                    multiline: true
                    text: qsTr("WARNING: Some NSFW videos are not been tagged as NSFW for now, so you may still see it in Search Results sometimes. Please enable app lock below.")
                    textStyle.color: Color.Red
                }
            }
            Header {
                title: qsTr("APP LOCK")
            }
            Container {
                leftPadding: 40.0
                rightPadding: 40.0
                bottomPadding: 20.0
                topPadding: 20
                Label {
                    text: qsTr("You'll be requested to type password during app startup, leave it empty to disable this feature.")
                    multiline: true
                    textStyle.fontWeight: FontWeight.W100
                    textStyle.fontSize: FontSize.XSmall
                }
                TextField {
                    id: input_password
                    hintText: qsTr("Password")
                    textFormat: TextFormat.Plain
                    inputMode: TextFieldInputMode.NumericPassword
                    input.submitKey: SubmitKey.Submit
                    input.submitKeyFocusBehavior: SubmitKeyFocusBehavior.Lose
                    input.onSubmitted: {
                        btn_set_password.clicked()
                    }
                    text: _app.getv("password", "")
                    onTextChanging: {
                        if (text.trim().length > 0) {
                            btn_set_password.enabled = true
                        } else {
                            btn_set_password.enabled = false
                        }
                    }
                }
                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    Button {
                        text: qsTr("Set")
                        appearance: ControlAppearance.Default
                        id: btn_set_password
                        onClicked: {
                            _app.setv("password", input_password.text)
                            settings_toast.body = qsTr("Password Set")
                            settings_toast.show();
                        }
                    }
                    Button {
                        text: qsTr("Clear")
                        onClicked: {
                            input_password.text = "";
                            _app.setv("password", "");
                            settings_toast.body = qsTr("Password Cleared.")
                            settings_toast.show();
                        }
                    }
                }
            }
            //            Container {
            //                layout: StackLayout {
            //                    orientation: LayoutOrientation.LeftToRight
            //
            //                }
            //                topPadding: 20.0
            //                leftPadding: 40.0
            //                rightPadding: 40.0
            //                bottomPadding: 20.0
            //                Label {
            //                    text: qsTr("Lock When Minimized")
            //                    verticalAlignment: VerticalAlignment.Center
            //                    layoutProperties: StackLayoutProperties {
            //                        spaceQuota: 1.0
            //                    }
            //                }
            //                ToggleButton {
            //                    enabled: input_password.text.length > 0
            //                    checked: _app.getv("autolock", "false") === "true"
            //                    onCheckedChanged: {
            //                        _app.setv("autolock", checked);
            //                    }
            //                }
            //            }
            //            Container {
            //                leftPadding: 40.0
            //                rightPadding: 40.0
            //                bottomPadding: 20.0
            //                Label {
            //                    multiline: true
            //                    text: qsTr("Lock this app automatically when it's minimized. Password is required for this to take action.")
            //                    textStyle.fontWeight: FontWeight.W100
            //                    textStyle.fontSize: FontSize.XSmall
            //                }
            //            }
            Header {
                title: qsTr("ADVANCED FEATURES")
            }
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight

                }
                topPadding: 20.0
                leftPadding: 40.0
                rightPadding: 40.0
                bottomPadding: 20.0
                Label {
                    text: qsTr("Enable Quick Translation")
                    verticalAlignment: VerticalAlignment.Center
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 1.0
                    }
                }
                ToggleButton {
                    id: toggle_translation
                    enabled: false
                }
            }
            Container {
                leftPadding: 40.0
                rightPadding: 40.0
                bottomPadding: 20.0
                DropDown {
                    enabled: toggle_translation.checked
                    title: qsTr("Translate to")
                    options: [
                        Option {
                            text: qsTr("Simp-Chinese")
                            value: "zh-cn"
                        },
                        Option {
                            id: op_english
                            text: qsTr("English")
                            value: "en-us"
                        }
                    ]
                    selectedOption: op_english
                }
                Label {
                    multiline: true
                    text: qsTr("*Will be available soon.")
                    textStyle.fontWeight: FontWeight.W100
                    textStyle.fontSize: FontSize.XSmall
                    textStyle.color: Color.create("#ff0082aa")

                }
            }
            Header {
                title: qsTr("MISC.")
            }

            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight

                }
                topPadding: 20.0
                leftPadding: 40.0
                rightPadding: 40.0
                bottomPadding: 20.0
                Label {
                    text: qsTr("This app automatically stores web images to local storage ( 50M Bytes at most ) , so typically you won't need to clear the cache manually. If you really want to, here's a button:")
                    verticalAlignment: VerticalAlignment.Center
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 1.0
                    }
                    multiline: true
                }
            }
            WebImageView {
                imageSource: "asset:///res/vid.png"
                scalingMethod: ScalingMethod.AspectFit
                visible: false
                id: stub_webImageView
            }
            Button {
                text: qsTr("CLEAR IMAGE CACHE")
                appearance: ControlAppearance.Primary
                enabled: true
                horizontalAlignment: HorizontalAlignment.Center
                onClicked: {
                    stub_webImageView.clearCache();
                    settings_toast.body = qsTr("Cache Cleared.")
                    settings_toast.show();
                    enabled = false;
                }
            }
            Divider {
                topMargin: 40.0
                opacity: 0.1
            }
        }
    }
}
