//
//  BlockNode.swift
//  Webrick
//
//  Created by kyota on 2019/06/23.
//  Copyright © 2019 kyotaw. All rights reserved.
//

import Foundation
import SpriteKit

class BlockNode : SKSpriteNode {
    init(jsBlock: JSBlock) {
        let left = jsBlock.rect["left"]!
        let right = jsBlock.rect["right"]!
        let bottom = jsBlock.rect["bottom"]!
        let top = jsBlock.rect["top"]!
        let blockRect = CGRect(x: left, y: bottom, width: right - left, height: top - bottom)
        self.jsBlock = jsBlock
        super.init(texture: nil, color: SKColor.green, size: blockRect.size)
        
        let physicsBody = SKPhysicsBody(rectangleOf: blockRect.size)
        physicsBody.isDynamic = false
        physicsBody.categoryBitMask = blockCategory
        self.physicsBody = physicsBody
        
        self.position = CGPoint(x: blockRect.midX, y: blockRect.midY)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let jsBlock: JSBlock
}
