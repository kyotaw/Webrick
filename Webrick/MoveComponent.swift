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
        self.node.physicsBody?.velocity = vector
        //self.node.position.x += vector.dxs
        //self.node.position.y += vector.dy
        
        /*
        if self.node.frame.minX < self.border.minX {
            self.node.position.x += (self.border.minX - self.node.frame.minX)
        }
        let nx = self.node.position.x
        let x = self.node.frame.maxX
        if self.border.maxX < self.node.frame.maxX {
            self.node.position.x -= (self.node.frame.maxX - self.border.maxX)
        }
        if self.node.frame.minY < self.border.minY {
            self.node.position.y += (self.border.minY - self.node.frame.minY)
        }
        if self.border.maxY < self.node.frame.maxY {
            self.node.position.y -= (self.node.frame.maxY - self.border.maxY)
        }*/
    }
    
    let node: SKNode
}
