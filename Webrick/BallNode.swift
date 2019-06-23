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
    
    init(size: CGSize) {
        super.init()
        let rec = CGRect(x:0, y:0, width:size.width, height:size.height)
        let corners: UIRectCorner = [UIRectCorner.topLeft, UIRectCorner.topRight, UIRectCorner.bottomLeft, UIRectCorner.bottomRight]
        self.path = UIBezierPath(roundedRect: rec, byRoundingCorners: corners, cornerRadii: CGSize(width: size.width / 2, height: size.height / 2)).cgPath
        self.fillColor = UIColor.blue
        self.strokeColor = UIColor.blue
        let physicsBody = SKPhysicsBody(circleOfRadius: 100)
        physicsBody.affectedByGravity = false
        physicsBody.linearDamping = 0
        physicsBody.restitution = 1
        physicsBody.usesPreciseCollisionDetection = true
        physicsBody.categoryBitMask = ballCategory
        physicsBody.contactTestBitMask = padleCategory | stageCategory
        physicsBody.collisionBitMask = padleCategory | stageCategory
        self.physicsBody = physicsBody
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
