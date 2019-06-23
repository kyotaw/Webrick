//
//  PadleEntity.swift
//  Webrick
//
//  Created by kyota on 2019/05/25.
//  Copyright © 2019 kyotaw. All rights reserved.
//

import Foundation
import GameplayKit


class PadleEntity : GKEntity {
    
    init(node: PadleNode) {
        self.node = node
        super.init()
        let spriteComponent = SpriteComponent(texture: SKTexture(imageNamed: "Padle"))
        self.addComponent(spriteComponent)
        let moveComponent = MoveComponent(node: node)
        self.addComponent(moveComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let node: PadleNode
}
