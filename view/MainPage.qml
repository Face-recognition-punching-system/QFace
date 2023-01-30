import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15
import QtQuick.LocalStorage 2.15

Page{
    id: root
    signal login()
    anchors.fill: parent
    onLogin: function(){
        console.debug("MainPage.qml: login")
        parent.login();
    }
    footer: TabBar{
        id: tabBar
        TabButton{
            display: AbstractButton.TextUnderIcon
            text: qsTr("记录")
            icon.source: "qrc:/QFace/assets/icon/record.png"
        }
        TabButton{
            display: AbstractButton.TextUnderIcon
            text: qsTr("打卡")
            icon.source: "qrc:/QFace/assets/icon/reco.png"
        }
        TabButton{
            display: AbstractButton.TextUnderIcon
            text: qsTr("个人")
            icon.source: "qrc:/QFace/assets/icon/user.png"
        }
    }
    StackLayout{
        anchors.fill: parent
        currentIndex: tabBar.currentIndex
        StackView{
            Item{
                id: reco
                anchors.fill: parent
            }
        }
        StackView{
            Item{
                id: record
                anchors.fill: parent
                Button{
                    text: qsTr("测试")
                }
            }
        }
        StackView{
            Loader{
                id: user
                anchors.fill: parent
            }
        }
    }
    Component{
        id: loginButton
        Item{
            anchors.fill: parent
            Button{
                anchors.horizontalCenter: parent
                anchors.verticalCenter: parent
                text: qsTr("登录")
                visible: !_isLogin
                onClicked: {
                    root.login();
                }
            }
        }
    }
    Component{
        id: userInfo
        ColumnLayout{
            anchors.fill: parent
            Image {
                width: 200
                height: 200
                id: name
                source: ""
                Layout.alignment: Qt.AlignHCenter
            }
            Button{
                text: qsTr("更新人脸")
                Layout.alignment: Qt.AlignHCenter
            }
            Button{
                text: qsTr("更改信息")
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
    Component.onCompleted: function(){
        console.debug(this.width, this.height)
        const db = LocalStorage.openDatabaseSync("QUserInfoDB", "1.0", "The user info database!", 1000000);
        db.transaction(function(tx){
            tx.executeSql('CREATE TABLE IF NOT EXISTS InfoTable(name TEXT, avatar TEXT)');
            var rs = tx.executeSql('SELECT * FROM InfoTable');
            if(rs.rows.length === 0){
                user.sourceComponent = loginButton
            }else{
                user.sourceComponent = userInfo
            }
        })
    }
}
