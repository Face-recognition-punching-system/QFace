import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.LocalStorage 2.15
import QtQuick.Shapes 1.15
import QtQuick.Dialogs 1.3

Page{
    id: root
    signal login
    property string id:""
    property string workerId:""
    property string name: ""
    property string age: ""
    property string department: ""
    onLogin: function(){
        console.debug("MainPage.qml: login")
        parent.login();
    }
    footer: TabBar{
        id: tabBar
        TabButton{
            display: AbstractButton.TextUnderIcon
            text: qsTr("反馈")
            icon.source: "qrc:/QFace/assets/icon/feedback.png"
        }
        TabButton{
            display: AbstractButton.TextUnderIcon
            text: qsTr("打卡")
            icon.source: "qrc:/QFace/assets/icon/clock.png"
        }
        TabButton{
            display: AbstractButton.TextUnderIcon
            text: qsTr("个人")
            icon.source: "qrc:/QFace/assets/icon/worker.png"
        }
    }
    StackLayout{
        id: tabView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex
        StackView{
            Item{
                id: feedback
                anchors.fill: parent
                Component{
                    id: feedbackItem
                    Item{
                        width: feedbackView.width
                        height: 80
                        RowLayout{
                            anchors.fill: parent
                            spacing: 10
                            Layout.fillWidth: false
                            Text {
                                text: create_time
                                color: "#fff"
                                Layout.alignment: Qt.AlignCenter
                            }
                            Button{
                                text: "查看"
                                Layout.alignment: Qt.AlignCenter
                            }
                            Button{
                                text: "反馈"
                                Layout.alignment: Qt.AlignCenter
                            }
                        }
                    }
                }
                ListModel{
                    id: feedbackModel
                }
                ListView{
                    id: feedbackView
                    anchors.fill: parent
                    model: feedbackModel
                    delegate: feedbackItem
                }
                Component.onCompleted: function(){
                    const xhr = new XMLHttpRequest()
                    xhr.open("POST", "http://192.168.2.101:8888/worker/getClock")
                    xhr.setRequestHeader("Content-Type", "application/json")
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState === XMLHttpRequest.DONE) {
                            const res = JSON.parse(xhr.responseText.toString())
                            if(Array.isArray(res)){
                                for(let i = 0, l = res.length; i < l; i++){
                                    console.log("hello world")
                                    feedbackModel.append(res[i])
                                }
                            }else{
                                console.error(res.message)
                            }
                        } else {
                            console.error("error")
                        }
                    }

                    xhr.onerror = function () {
                        console.error("error")
                    }

                    const data = console.log()
                    xhr.send(JSON.stringify({
                                                "id": root.id,
                                            }))
                }
            }
        }
        StackView{
            Item{
                id: clock
                anchors.fill: parent
                Component{
                    id: clockItem
                    Item{
                        width: clockView.width
                        height: 80
                        RowLayout{
                            anchors.fill: parent
                            spacing: 10
                            Layout.fillWidth: false
                            Text {
                                text: create_time
                                color: "#fff"
                                Layout.alignment: Qt.AlignCenter
                            }
                            Button{
                                text: "查看"
                                Layout.alignment: Qt.AlignCenter
                            }
                            Button{
                                text: "反馈"
                                Layout.alignment: Qt.AlignCenter
                            }
                        }
                    }
                }
                ListModel{
                    id: clockModel
                }
                ListView{
                    id: clockView
                    anchors.fill: parent
                    model: clockModel
                    delegate: clockItem
                }
                Component.onCompleted: function(){
                    const xhr = new XMLHttpRequest()
                    xhr.open("POST", "http://192.168.2.101:8888/worker/getClock")
                    xhr.setRequestHeader("Content-Type", "application/json")
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState === XMLHttpRequest.DONE) {
                            const res = JSON.parse(xhr.responseText.toString())
                            if(Array.isArray(res)){
                                for(let i = 0, l = res.length; i < l; i++){
                                    console.log("hello world")
                                    clockModel.append(res[i])
                                }
                            }else{
                                console.error(res.message)
                            }
                        } else {
                            console.error("error")
                        }
                    }

                    xhr.onerror = function () {
                        console.error("error")
                    }

                    const data = console.log()
                    xhr.send(JSON.stringify({
                                                "id": root.id,
                                            }))
                }
                Dialog{
                    id: feedbackDialog

                }
            }
        }
        StackView{
            Item{
                id: worker
                anchors.fill: parent
                Loader{
                    id: workerLoader
                    anchors.fill: parent
                }
            }
        }
    }
    Component{
        id: loginButton
        Item{
            Button{
                anchors.centerIn: parent
                text: qsTr("登录")
                onClicked: {
                    root.login();
                }
            }
        }
    }
    Component{
        id: workerInfo
        Item{
            Row{
                anchors.centerIn: parent
                width: parent.width
                spacing: 24
                Column{
                    spacing: 24
                    width: 0.4 * parent.width
                    Repeater{
                        model: [qsTr("员工号"), qsTr("姓名"), qsTr("年龄"), qsTr("部门")]
                        Label{
                            text: modelData + ":"
                            font.family: "Microsoft YaHei"
                            font.pixelSize: 24
                            horizontalAlignment: Text.AlignRight
                            width: parent.width
                        }
                    }
                }
                Column{
                    spacing: 24
                    width: 0.6 * parent.width
                    Repeater{
                        model: [root.workerId, root.name, root.age, root.department]
                        Item{
                            width: 0.6 * parent.width
                            height: children[0].contentHeight
                            Text {
                                text: modelData
                                color: "#fff"
                                font.family: "Microsoft YaHei"
                                font.pixelSize: 24
                            }
                            Shape{
                                anchors.fill: parent
                                ShapePath{
                                    strokeWidth: 1
                                    strokeColor: "#00aba9"
                                    strokeStyle: ShapePath.SolidLine
                                    startX: 0
                                    startY: 28
                                    PathLine{
                                        x: 120
                                        y: 28
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    Component.onCompleted: function(){
        console.debug(this.width, this.height)
        const db = LocalStorage.openDatabaseSync("QUserInfoDB", "1.0", "The worker info database!", 1000000);
        db.transaction(function(tx){
            tx.executeSql('CREATE TABLE IF NOT EXISTS worker(id TEXT, workerId TEXT, name Text, age Text, department Text)');
            const rs = tx.executeSql('SELECT * FROM worker');
            console.debug(rs.rows[0])
            if(rs.rows.length === 0){
                workerLoader.sourceComponent = loginButton
            }else{
                root.id = rs.rows[0].id
                root.workerId = rs.rows[0].workerId
                root.name = rs.rows[0].name
                root.age = rs.rows[0].age
                root.department = rs.rows[0].department
                workerLoader.sourceComponent = workerInfo
            }
        })
    }
}
