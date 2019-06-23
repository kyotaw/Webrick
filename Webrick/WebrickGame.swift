//
//  WebrickGame.swift
//  Webrick
//
//  Created by kyota on 2019/05/26.
//  Copyright © 2019 kyotaw. All rights reserved.
//

import Foundation
import GameplayKit


class WebrickGame: NSObject, SKSceneDelegate {
    init(stageRect: CGRect) {
        let stageSize = CGSize(width: stageRect.width, height: stageRect.height)
        // load scene
        self.playScene = PlayScene(size: stageSize)
        
        // load padle
        let padleNode = PadleNode(size: CGSize(width: 20, height: 5))
        let padleEntity = PadleEntity(node: padleNode)
        self.playScene.addChild(padleNode)
        
        // load ball
        let ballNode = BallNode(size: CGSize(width: 100, height: 100))
        let ballEntity = BallEntity(node: ballNode)
        self.playScene.addChild(ballNode)
        
        self.spriteComponentSystem = GKComponentSystem(componentClass: SpriteComponent.self)
        self.spriteComponentSystem.addComponent(foundIn: padleEntity)
        self.spriteComponentSystem.addComponent(foundIn: ballEntity)
        self.moveComponentSystem = GKComponentSystem(componentClass: MoveComponent.self)
        self.moveComponentSystem.addComponent(foundIn: padleEntity)
        self.moveComponentSystem.addComponent(foundIn: ballEntity)
        
        super.init()
        self.playScene.delegate = self
    }
    
    func update(_ currentTime: TimeInterval, for scene: SKScene) {
        for move in self.moveComponentSystem.components {
            let vec = CGVector(dx:100, dy: 30)
            move.move(vector: vec)
        }
        //self.moveComponentSystem.update(deltaTime: currentTime)
    }

    var playScene: PlayScene
    let spriteComponentSystem: GKComponentSystem<SpriteComponent>
    let moveComponentSystem: GKComponentSystem<MoveComponent>
}
