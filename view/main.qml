import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.2

ApplicationWindow {
    id: root
    visible: true
    visibility: "Maximized"
    property bool _isLogin: false
    StackView{
        id: pageStack
        anchors.fill: parent
        signal login()
        signal loginSuccess()
        onLogin: function(){
            console.debug("main.qml: login")
            pageStack.push(loginPage)
        }
        onLoginSuccess: function(){
            const i = pageStack.children.length - 1
            pageStack.pop()
        }
    }
    Component.onCompleted: function(){
        console.debug("APP launch")
        console.debug("width = ", this.width, " height = ", this.height)
        pageStack.push(mainPage)
    }
    Component{
        id: mainPage
        MainPage{}
    }
    Component{
        id: loginPage
        LoginPage{}
    }
}
