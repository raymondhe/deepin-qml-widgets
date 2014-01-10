import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0

Rectangle {
    id: expandRect

    property alias header: header
    property alias content: content
    property alias headerData: header.componentData
    property alias contentData: content.componentData
    property bool expanded: false

    property var dconstants: DConstants {}

    height: headerRect.height + contentRect.height
    width: parent.width

    signal contentLoaded

    Column {
        width: parent.width

        Rectangle {
            id: headerRect
            width: parent.width
            height: 28
            clip: true
            color: dconstants.bgColor

            Loader {
                id: header
                width: headerRect.width
                property var componentData: undefined
                anchors.verticalCenter: parent.verticalCenter
            }
        }


        Rectangle {
            id: contentRect
            width: parent.width
            height: expanded ? content.height + 2 : 0
            clip: true
            color: dconstants.contentBgColor

            Column {
                width: parent.width
                DSeparatorHorizontal {}
                
                Loader {
                    id: content
                    clip: true
                    width: headerRect.width
                    property var componentData: undefined
                    height: sourceComponent.height
                    onLoaded: {
                        expandRect.contentLoaded()
                    }
                }
            }

            Behavior on height {
                SmoothedAnimation { duration: 200 }
            }
        }

        //DSeparatorHorizontal { visible: expanded }
    }
}

