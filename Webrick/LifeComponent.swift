//
//  LifeComponent.swift
//  Webrick
//
//  Created by kyota on 2019/06/23.
//  Copyright © 2019 kyotaw. All rights reserved.
//

import Foundation
import GameplayKit


class LifeComponent: GKComponent {
    init(node: SKNode, life: Int) {
        self.node = node
        self.life = life
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isDead: Bool {
        return self.life <= 0
    }
    
    func decrease(amount: Int) {
        self.life -= amount
        if self.life < 0 {
            self.life = 0
        }
    }
    
    let node: SKNode
    var life: Int
}
