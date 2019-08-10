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
        
        let physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody.affectedByGravity = false
        physicsBody.allowsRotation = false
        physicsBody.angularDamping = 0
        physicsBody.friction = 0
        physicsBody.linearDamping = 0
        physicsBody.restitution = 1
        physicsBody.usesPreciseCollisionDetection = true
        physicsBody.categoryBitMask = padleCategory
        //physicsBody.contactTestBitMask = stageCategory
        //physicsBody.collisionBitMask = stageCategory
        physicsBody.velocity = CGVector(dx: 100, dy: 0)
        self.physicsBody = physicsBody

        self.position = CGPoint(x: stageRect.midX, y: size.height * 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
