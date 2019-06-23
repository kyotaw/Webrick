//
//  GameViewController.swift
//  Webrick
//
//  Created by kyota on 2019/05/24.
//  Copyright © 2019 kyotaw. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import WebKit

func loadScript(name: String) -> String {
    var jsSource = ""
    let path = Bundle.main.path(forResource: name, ofType: "js")!
    if let data = NSData(contentsOfFile: path){
        jsSource = String(NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)!)
    }
    return jsSource
}

class GameViewController: UIViewController, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
    
    override func loadView() {
        let jsSource = loadScript(name: "js/init")
        
        // WKUserScriptを作成、injectionTimeにJavaScriptを実行するタイミングを指定します
        let userScript1 = WKUserScript(source: jsSource, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: true)
        
        let controller = WKUserContentController()
        controller.addUserScript(userScript1)
        controller.add(self, name: JsHandler.initHandler.rawValue)
        
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.userContentController = controller
        
        self.webView = WKWebView(frame: .zero, configuration: webConfiguration)
        self.webView.uiDelegate = self
        self.view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let myURL = URL(string:"https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        self.webView.load(myRequest)
        
        let stateRect: CGRect = UIScreen.main.bounds
        self.game = WebrickGame(stageRect: stateRect)
        
        let skview = SKView()
        let viewSize = UIScreen.main.bounds.size
        let viewRect = CGRect(x: 0, y: 0, width: viewSize.width, height: viewSize.height)
        skview.frame = viewRect
        skview.presentScene(self.game.playScene)
        skview.ignoresSiblingOrder = true
        skview.showsFPS = true
        skview.showsNodeCount = true
        skview.allowsTransparency = true

        self.view.addSubview(skview)
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if(message.name == JsHandler.initHandler.rawValue) {
            print(message.body)
            let script = loadScript(name: "js/buildStage")
            self.webView.evaluateJavaScript(script, completionHandler: buildStageHandler)
        }
    }
    
    func buildStageHandler(res: Any?, error: Error?) {
        print(res)
        print(error.debugDescription)
    }
    
    var webView: WKWebView!
    var skView: SKView!
    var game: WebrickGame!
}
