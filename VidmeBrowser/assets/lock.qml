import bb.cascades 1.4
Sheet {
    id: sheetroot
    peekEnabled: false
    onCreationCompleted: {
        input_password.requestFocus()
        anim.play()
    }
    attachedObjects: [
        SequentialAnimation {
            id: anim
            target: appimage
            repeatCount: Infinity
            animations: [
                FadeTransition {
                    target: appimage
                    toOpacity: 0.2
                    fromOpacity: 1.0
                },
                FadeTransition {
                    target: appimage
                    toOpacity: 1.0
                    fromOpacity: 0.2
                }
            ]
        }
    ]
    Page {
        titleBar: TitleBar {
            title: qsTr("Application Locked")
        }
        Container {
            topPadding: 50.0
            leftPadding: 40.0
            rightPadding: 40.0
            bottomPadding: 50.0
            ImageView {
                id: appimage
                imageSource: "asset:///res/vid.png"
                scalingMethod: ScalingMethod.AspectFit
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Center
                preferredHeight: ui.du(20)
            }
            Label {
                text: qsTr("Password Incorrect")
                textStyle.textAlign: TextAlign.Center
                horizontalAlignment: HorizontalAlignment.Fill
                textStyle.color: Color.Red
                enabled: true
                visible: false
                id: wrongpassword_tip
            }
            TextField {
                id: input_password
                onTextChanging: {
                    wrongpassword_tip.visible = false;
                }
                hintText: qsTr("Password Required")
                inputMode: TextFieldInputMode.NumericPassword
                input.submitKeyFocusBehavior: SubmitKeyFocusBehavior.Lose
                textFormat: TextFormat.Plain
                topMargin: 40.0
                input.onSubmitted: {
                    if (text == _app.getv("password", "") && text != "") {
                        sheetroot.close()
                    } else {
                        wrongpassword_tip.visible = true;
                    }
                }
                input.submitKey: SubmitKey.Submit
            }
            Button {
                horizontalAlignment: HorizontalAlignment.Center
                text: qsTr("Unlock")
                appearance: ControlAppearance.Primary
                onClicked: {
                    if (input_password.text == _app.getv("password", "") && input_password.text != "") {
                        sheetroot.close()
                    } else {
                        wrongpassword_tip.visible = true;
                    }
                }
            }
        }
    }

}