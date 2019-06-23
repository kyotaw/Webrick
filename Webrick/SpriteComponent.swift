//
//  SpriteComponent.swift
//  Webrick
//
//  Created by kyota on 2019/05/25.
//  Copyright © 2019 kyotaw. All rights reserved.
//

import Foundation
import GameplayKit


class SpriteComponent: GKComponent {
    let node: SKSpriteNode
    
    init(texture: SKTexture) {
        self.node = SKSpriteNode(texture: texture, color: .white, size: texture.size())
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
