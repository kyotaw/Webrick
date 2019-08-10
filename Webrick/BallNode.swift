//
//  BallNode.swift
//  Webrick
//
//  Created by kyota on 2019/06/22.
//  Copyright © 2019 kyotaw. All rights reserved.
//

import Foundation
import SpriteKit

class BallNode : SKShapeNode {
    
    init(size: CGSize, padleRect: CGRect) {
        super.init()
        
        let radius = size.width / 2
        
        let physicsBody = SKPhysicsBody(circleOfRadius: radius)
        physicsBody.affectedByGravity = false
        physicsBody.allowsRotation = false
        physicsBody.angularDamping = 0
        physicsBody.friction = 0
        physicsBody.linearDamping = 0
        physicsBody.restitution = 1
        physicsBody.usesPreciseCollisionDetection = true
        physicsBody.categoryBitMask = ballCategory
        physicsBody.contactTestBitMask = padleCategory | stageCategory | blockCategory
        physicsBody.collisionBitMask = padleCategory | stageCategory | blockCategory
        physicsBody.velocity = CGVector(dx: 300, dy: 300)
        self.physicsBody = physicsBody
        
        let rec = CGRect(x: -radius, y: -radius, width:size.width, height:size.height)
        let corners: UIRectCorner = [UIRectCorner.topLeft, UIRectCorner.topRight, UIRectCorner.bottomLeft, UIRectCorner.bottomRight]
        self.path = UIBezierPath(roundedRect: rec, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        self.fillColor = UIColor.blue
        self.strokeColor = UIColor.blue
        self.position = CGPoint(x: padleRect.midX - radius, y: padleRect.maxY);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
