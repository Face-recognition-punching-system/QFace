import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15

Page{
    id: root
    anchors.fill: parent
    signal loginSuccess()
    onLoginSuccess: function(){
        console.debug("LoginPage.qml: login success");
    }
    property bool _accountAcceptable: false
    property bool _passwordAcceptable: false
    background: Rectangle{
        color: Material.Pink
    }
    ColumnLayout{
        anchors.centerIn: parent
        width: 300
        spacing: 20
        RowLayout{
            Layout.alignment: Qt.AlignCenter
            Layout.maximumWidth: 300
            Layout.preferredHeight: 40
            Label{
                Layout.alignment: Qt.AlignVCenter
                text: qsTr("账号")
                font.pointSize: 16
            }
            Control{
                Layout.fillWidth: true
                Layout.fillHeight: true
                background: Rectangle{
                    border.width: 2
                    border.color: "#555555"
                }
                TextInput{
                    height: parent.height
                    width: parent.width - 40
                    anchors.centerIn: parent
                    id: account
                    font.pointSize: 16
                    verticalAlignment: Text.AlignVCenter
                    validator: RegularExpressionValidator{regularExpression: /^[A-Za-z0-9]{8,16}$/}
                    clip: true
                    onTextEdited: function(){
                        console.debug("editing")
                    }
                    onAccepted: function(){
                        console.debug("accepted")
                    }
                }
            }
        }
        RowLayout{
            Layout.alignment: Qt.AlignCenter
            Layout.maximumWidth: 300
            Layout.preferredHeight: 40
            Label{
                Layout.alignment: Qt.AlignVCenter
                text: qsTr("密码")
                font.pointSize: 16
            }
            Control{
                Layout.fillWidth: true
                Layout.fillHeight: true
                background: Rectangle{
                    border.width: 2
                    border.color: "#555555"
                }
                TextInput{
                    height: parent.height
                    width: parent.width - 40
                    anchors.centerIn: parent
                    id: password
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 16
                    echoMode: TextInput.Password
                    validator: RegularExpressionValidator{regularExpression: /^[A-Za-z0-9]{8,16}$/}
                    clip: true
                    onTextEdited: function(){
                        console.debug("editing")
                    }
                    onAccepted: function(){
                        console.debug("accepted")
                    }
                }
            }
        }
        Button{
            Layout.alignment: Qt.AlignCenter
            Layout.preferredWidth: 100
            Layout.preferredHeight: 40
            text: qsTr("登录")
            onClicked: function(){
                if(_accountAcceptable & _passwordAcceptable){
                    root.loginSuccess()
                }else{
                    if(!_accountAcceptable){
                        dialog.visible = true
                        dialogText.text = qsTr("账号格式不对")
                    }else if(!_passwordAcceptable){
                        dialog.visible = true
                        dialogText.text = qsTr("密码格式不对")
                    }
                }
            }

        }
        Text{
            Layout.alignment: Qt.AlignRight
            text: qsTr("忘记密码？")
            font.underline: true
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                preventStealing: true
                propagateComposedEvents: true
                enabled: true
                onClicked: function(){
                    console.debug("forget password")
                }
            }
        }
    }
    Dialog {
        anchors.centerIn: parent
        id: dialog
        title: qsTr("提示")
        visible: false
        contentItem: Rectangle {
            color: "lightskyblue"
            implicitWidth: 200
            implicitHeight: 80
            Text {
                id: dialogText
                anchors.centerIn: parent
            }
        }
    }
}
