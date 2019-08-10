//
//  MoveComponent.swift
//  Webrick
//
//  Created by kyota on 2019/05/26.
//  Copyright © 2019 kyotaw. All rights reserved.
//

import Foundation
import GameplayKit


class MoveComponent: GKComponent {
    init(node: SKNode) {
        self.node = node
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func move(vector: CGVector) {
        print(self.node.physicsBody?.velocity)
        self.node.physicsBody?.velocity.dx *= 1.001
        self.node.physicsBody?.velocity.dy *= 1.001
    }
    
    let node: SKNode
}
