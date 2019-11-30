import QtQuick 2.9
import Ubuntu.Components 1.3
import QtQuick.Window 2.2
import Morph.Web 0.1
import "UCSComponents"
import QtWebEngine 1.7
import Qt.labs.settings 1.0
import QtSystemInfo 5.5

MainView {
id:window

ScreenSaver {
id: screenSaver
screenSaverEnabled: !(Qt.application.active)
}
    objectName: "mainView"
        theme.name: "Ubuntu.Components.Themes.SuruDark"

    applicationName: "vk.turrbor"


backgroundColor : "transparent"

    

        
   WebEngineView {
   id: webview
    anchors{ fill: parent}


 
           settings.fullScreenSupportEnabled: true
       property var currentWebview: webview
           settings.pluginsEnabled: true

           
                    onFullScreenRequested: function(request) {
       nav.visible = !nav.visible

       request.accept();
   }



       
profile:  WebEngineProfile{
id: webContext
    persistentCookiesPolicy: WebEngineProfile.ForcePersistentCookies
       property alias dataPath: webContext.persistentStoragePath

            dataPath: dataLocation


    
        httpUserAgent: "Mozilla/5.0 (Linux; Android 8.0.0; Pixel Build/OPR3.170623.007) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.98 Mobile Safari/537.36"
    }

        anchors{fill:parent
    centerIn: parent.verticalCenter}

              

       url: "http://vk.com"
 userScripts: [
WebEngineScript {
  injectionPoint: WebEngineScript.DocumentCreation
worldId: WebEngineScript.MainWorld
name: "QWebChannel"
sourceUrl: "ubuntutheme.js"
}
]

    
    }
       RadialBottomEdge {
            id: nav
            visible: true
            actions: [
                RadialAction {
                    id: reload
                    iconName: "reload"
                    onTriggered: {
                        webview.reload()
                    }
                    text: qsTr("Обновить")
                },
                
                RadialAction {
                    id: forward
                    enabled: webview.canGoForward
                    iconName: "go-next"
                    onTriggered: {
                        webview.goForward()
                    }
                   text: qsTr("Вперед")
                 },
                    RadialAction {
                    id: account
                    iconName: "message"
                    onTriggered: {
                        webview.url = 'https://vk.com/im'
                    }
                    text: qsTr("Сообщения")
                    
                },
                    RadialAction {
                    id: subscriptions
                    iconName: "account"
                    onTriggered: {
                        webview.url = 'https://vk.com/groups'
                    }
                    text: qsTr("Группы")
                    
                },
                  RadialAction {
                    id: trending
                    iconName: "weather-chance-of-storm"
                    onTriggered: {
                        webview.url = 'https://vk.com/feed?section=updates'
                    }
                    text: qsTr("Обновления")
                },
               
                RadialAction {
                    id: home
                    iconName: "home"
                    onTriggered: {
                        webview.url = 'http://vk.com'
                    }
                    text: qsTr("Главная")
                },
             

            
                  RadialAction {
                    id: back
                    enabled: webview.canGoBack
                    iconName: "go-previous"
                    onTriggered: {
                        webview.goBack()
                    }
                    text: qsTr("Назад")
                }
            ]
            
    
   
   
        }
        
        
       
        
         Connections {
        target: Qt.inputMethod
        onVisibleChanged: nav.visible = !nav.visible
    }
    
    Connections {
        target: webview

                        onIsFullScreenChanged: {
                        window.setFullscreen()
                        if (currentWebview.isFullScreen) {

                    nav.state = "hidden"
        }
        else {

        nav.state = "shown"
        }
   }
    
    }
     Connections {
        target: window.webview
    
               onIsFullScreenChanged: window.setFullscreen(window.webview.isFullScreen)
               }
                      function setFullscreen(fullscreen) {
         if (!window.forceFullscreen) {
             if (fullscreen) {
                 if (window.visibility != Window.FullScreen) {
                     internal.currentWindowState = window.visibility
                    window.visibility = 5
                }
            } else {
                window.visibility = internal.currentWindowState
                //window.currentWebview.fullscreen = false
                //window.currentWebview.fullscreen = false
            }
        }
               
         
        }
 
}
