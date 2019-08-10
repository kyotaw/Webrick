//
//  BallEntity.swift
//  Webrick
//
//  Created by kyota on 2019/05/26.
//  Copyright © 2019 kyotaw. All rights reserved.
//

import Foundation
import GameplayKit


class BallEntity: GKEntity {
    init(node: BallNode) {
        self.node = node
        super.init()
        self.node.entity = self
        let spriteComponent = SpriteComponent(texture: SKTexture(imageNamed: "Ball"))
        self.addComponent(spriteComponent)
        let moveComponent = MoveComponent(node: node)
        self.addComponent(moveComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let node: BallNode
}
