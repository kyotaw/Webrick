//
//  GameScene.swift
//  Webrick
//
//  Created by kyota on 2019/05/24.
//  Copyright © 2019 kyotaw. All rights reserved.
//

import SpriteKit
import GameplayKit

let stageCategory: UInt32 = 0x1 << 0
let ballCategory: UInt32 = 0x1 << 1
let padleCategory: UInt32 = 0x1 << 2


class PlayScene: SKScene, SKPhysicsContactDelegate {
    
    override init(size: CGSize) {
        super.init(size: size)
        
        self.scaleMode = .aspectFill
        self.backgroundColor = SKColor(white: 0, alpha: 0)
        
        let physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        physicsBody.categoryBitMask = stageCategory
        self.physicsBody = physicsBody
        self.physicsWorld.contactDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
    }
    
    override func didMove(to view: SKView) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        self.lastUpdateTime = currentTime
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        contact.bodyA.velocity = CGVector()
        contact.bodyB.velocity = CGVector()
    }

    private var lastUpdateTime : TimeInterval = 0
}
