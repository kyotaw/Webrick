//
//  File.swift
//  Webrick
//
//  Created by kyota on 2019/06/23.
//  Copyright © 2019 kyotaw. All rights reserved.
//

import Foundation
import GameplayKit


class BlockEntity: GKEntity {
    init(node: BlockNode) {
        self.node = node
        self.life = LifeComponent(node: node, life: 1)
        super.init()
        self.node.entity = self
        self.addComponent(self.life)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isDead: Bool {
        return self.life.isDead
    }
    
    func crash(ball: BallEntity) {
        self.life.decrease(amount: 1)
    }
    
    func destroy() {
        self.node.removeFromParent()
    }
    
    let node: BlockNode
    let life: LifeComponent
}
