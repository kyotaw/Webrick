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
let blockCategory: UInt32 = 0x1 << 3


class PlayScene: SKScene {
    
    override init(size: CGSize) {
        super.init(size: size)
        let physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        physicsBody.categoryBitMask = stageCategory
        self.physicsBody = physicsBody
        
        self.scaleMode = .aspectFill
        self.backgroundColor = SKColor(white: 0, alpha: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sceneDidLoad() {
    }
    
    override func didMove(to view: SKView) {
        
    }
}
