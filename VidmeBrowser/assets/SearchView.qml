import bb.cascades 1.4

Page {
    property variant nav
    titleBar: TitleBar {
        title: qsTr("Search Videos")
        scrollBehavior: TitleBarScrollBehavior.NonSticky

    }
    ScrollView {
        scrollRole: ScrollRole.Main
        Container {
            Container {
                horizontalAlignment: HorizontalAlignment.Fill
                ImageView {
                    preferredHeight: ui.du(16)
                    imageSource: "asset:///res/logo_light_bg_powered_by.png"
                    scalingMethod: ScalingMethod.AspectFit
                    loadEffect: ImageViewLoadEffect.Default
                    horizontalAlignment: HorizontalAlignment.Right
                }
            }
            Header {
                title: qsTr("QUERY FOR")
            }
            TextField {
                id: input_query
                hintText: qsTr("What are you looking for ?")
                onTextChanging: {
                    if (text.trim().length > 0) {
                        actionitem_search.enabled = true
                    } else {
                        actionitem_search.enabled = false
                    }
                }
                input.submitKey: SubmitKey.Search
                input.submitKeyFocusBehavior: SubmitKeyFocusBehavior.Lose
                input.onSubmitted: {
                    if (actionitem_search.enabled) {
                        actionitem_search.triggered();
                    }
                }
            }
            Header {
                title: qsTr("OPTIONS")
            }
            Container {
                leftPadding: 20.0
                rightPadding: 20.0
                topPadding: 20.0
                bottomPadding: 20.0
                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    Label {
                        text: qsTr("Include NSFW Content")
                        layoutProperties: StackLayoutProperties {
                            spaceQuota: 1
                        }
                        verticalAlignment: VerticalAlignment.Center
                    }
                    ToggleButton {
                        id: option_nsfw_toggle
                        verticalAlignment: VerticalAlignment.Center
                    }
                }
                DropDown {
                    id: option_sortby_dropdown
                    verticalAlignment: VerticalAlignment.Center
                    options: [
                        Option {
                            text: qsTr("Likes Count")
                            value: "likes_count"
                        },
                        Option {
                            text: qsTr("Hot Score")
                            value: "hot_score"
                        },
                        Option {
                            text: qsTr("Score")
                            value: "score"
                        },
                        Option {
                            text: qsTr("Date")
                            value: "date_completed"
                        }
                    ]
                    title: qsTr("Sort By")
                    selectedIndex: 0
                    //likes_count, hot_score, score, date_completed
                }

            }

        }
    }
    actions: [
        ActionItem {
            id: actionitem_search
            enabled: false
            title: qsTr("Search")
            ActionBar.placement: ActionBarPlacement.Signature
            onTriggered: {
                var searchresult = Qt.createComponent("SearchResultView.qml").createObject(nav);
                searchresult.query = input_query.text;
                searchresult.nsfw = option_nsfw_toggle.checked;
                searchresult.order = option_sortby_dropdown.selectedValue
                searchresult.doQuery();
                nav.push(searchresult);
            }
            imageSource: "asset:///icon/ic_search.png"
        }
    ]
    actionBarVisibility: ChromeVisibility.Compact

}
