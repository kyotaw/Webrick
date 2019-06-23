//
//  PadleNode.swift
//  Webrick
//
//  Created by kyota on 2019/06/22.
//  Copyright © 2019 kyotaw. All rights reserved.
//

import Foundation
import SpriteKit

class PadleNode : SKSpriteNode {
    
    init(size: CGSize, stageRect: CGRect) {
        super.init(texture: nil, color: SKColor.red, size: size)
        
        self.position = CGPoint(x: stageRect.midX, y: size.height)
        let physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        physicsBody.affectedByGravity = false
        physicsBody.linearDamping = 0
        physicsBody.restitution = 1
        physicsBody.usesPreciseCollisionDetection = true
        physicsBody.categoryBitMask = padleCategory
        physicsBody.contactTestBitMask = stageCategory
        physicsBody.collisionBitMask = stageCategory
        self.physicsBody = physicsBody
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
