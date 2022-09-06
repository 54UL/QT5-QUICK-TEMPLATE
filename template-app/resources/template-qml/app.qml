import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Qt.labs.platform 1.1
import QtQuick.Window 2.12

ApplicationWindow 
{
    id: template_app_window
    visible: true
    width: 760
    height: 540
    background: Rectangle { color: "#9575cd"}

    property var counter: 69420

    Rectangle
    {
        color: "#c7a4ff"
        radius: 10
        anchors.fill: parent
        anchors.margins: 10
        border.width: 12
        border.color: "#65499c"

        ColumnLayout
        {
            anchors.fill: parent
            
            Button 
            {
                text: "Press me!"
                Layout.preferredHeight: 50
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                Layout.topMargin: 32

                onClicked: 
                {
                    counter++
                }
            }

            Text
            {
                horizontalAlignment: Text.AlignHCenter
                text: `Button pressed ${counter} times!!! wtff`
                Layout.preferredHeight: 20
                Layout.fillWidth: true
                font.pointSize: 32
            }
        }
    }
}
