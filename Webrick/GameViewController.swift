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

class GameViewController: UIViewController, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler, WebrickGameDelegate {
    
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

        let myURL = URL(string:"https://www.slant.co/topics/3822/~best-2d-game-engines-for-ios")
        let myRequest = URLRequest(url: myURL!)
        self.webView.load(myRequest)
        
        let stateRect: CGRect = UIScreen.main.bounds
        self.game = WebrickGame(stageRect: stateRect)
        self.game.delegate = self
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        self.safeAreaTop = Double(UIApplication.shared.keyWindow!.safeAreaInsets.top)
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
            let script = loadScript(name: "js/parseStage")
            self.webView.evaluateJavaScript(script, completionHandler: onCompleteParseStage)
        }
    }
    
    func onCompleteParseStage(res: Any?, error: Error?) {
        if let err = error {
            print(err)
            return
        }
        print(res)
        guard let data = (res as! String).data(using: .utf8) else {
            return
        }
        do {
            var stageRes = try JSONDecoder().decode(ParseStageResponse.self, from: data)
            stageRes.stage.blocks = stageRes.stage.blocks.map { block in
                var rect = block.rect
                rect["bottom"] = Double(self.game.stageRect.height) - block.rect["bottom"]! - self.safeAreaTop
                rect["top"] = Double(self.game.stageRect.height) - block.rect["top"]! - self.safeAreaTop
                return JSBlock(id: block.id, rect: rect, content: block.content)
            }

            self.game.addBlocks(blocks: stageRes.stage.blocks)
        } catch let jsonErr {
            print(jsonErr)
            return
        }
    }
    
    func onCompleteDestroyBlock(res: Any?, error: Error?) {
        print(error)
    }
    
    // WebrickGameDelegate
    func destroyedBlock(jsBlock: JSBlock) {
        let blockId = jsBlock.id
        self.webView.evaluateJavaScript("window.destoryBlock('\(blockId)');", completionHandler: onCompleteDestroyBlock)
    }
    
    var webView: WKWebView!
    var skView: SKView!
    var game: WebrickGame!
    var safeAreaTop: Double!
}
