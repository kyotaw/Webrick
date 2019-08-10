//
//  WebrickGame.swift
//  Webrick
//
//  Created by kyota on 2019/05/26.
//  Copyright © 2019 kyotaw. All rights reserved.
//

import Foundation
import GameplayKit

protocol WebrickGameDelegate {
    func destroyedBlock(jsBlock: JSBlock)
}


class WebrickGame: NSObject, SKSceneDelegate, SKPhysicsContactDelegate {
    init(stageRect: CGRect) {
        self.stageRect = stageRect
        let stageSize = CGSize(width: stageRect.width, height: stageRect.height)
        // scene
        self.playScene = PlayScene(size: stageSize)
        
        // padle
        let padleSize = CGSize(width: stageSize.width / 5, height: stageSize.height / 30)
        let padleNode = PadleNode(size: padleSize, stageRect: stageRect)
        self.padleEntity = PadleEntity(node: padleNode)
        self.playScene.addChild(padleNode)
        
        // ball
        let ballSize = CGSize(width: 30, height: 30)
        let ballNode = BallNode(size: ballSize, padleRect: padleNode.frame)
        self.ballEntity = BallEntity(node: ballNode)
        self.playScene.addChild(ballNode)
        
        // block
        self.blockEntities = []
        
        self.spriteComponentSystem = GKComponentSystem(componentClass: SpriteComponent.self)
        self.moveComponentSystem = GKComponentSystem(componentClass: MoveComponent.self)
        self.lifeComponentSystem = GKComponentSystem(componentClass: LifeComponent.self)
        
        super.init()
        self.spriteComponentSystem.addComponent(foundIn: self.padleEntity)
        self.spriteComponentSystem.addComponent(foundIn: self.ballEntity)
        self.moveComponentSystem.addComponent(foundIn: self.padleEntity)
        self.moveComponentSystem.addComponent(foundIn: self.ballEntity)
        self.playScene.delegate = self
        self.playScene.physicsWorld.contactDelegate = self
    }
    
    func addBlocks(blocks: Array<JSBlock>) {
        for block in blocks {
            let blockNode = BlockNode(jsBlock: block)
            self.playScene.addChild(blockNode)
            let blockEntity = BlockEntity(node: blockNode)
            self.lifeComponentSystem.addComponent(foundIn: blockEntity)
            self.blockEntities.append(blockEntity)
        }
    }
    
    // SKSceneDelegate
    func update(_ currentTime: TimeInterval, for scene: SKScene) {
        //self.moveComponentSystem.update(deltaTime: currentTime)
    }
    
    // SKPhysicsContactDelegate
    func didBegin(_ contact: SKPhysicsContact) {
        switch contact.bodyA.categoryBitMask {
        case ballCategory:
            if contact.bodyB.categoryBitMask == blockCategory {
                let ball = contact.bodyA.node?.entity as! BallEntity
                let block = contact.bodyB.node?.entity as! BlockEntity
                block.crash(ball: ball)
                if block.isDead {
                    block.destroy()
                    self.delegate?.destroyedBlock(jsBlock: block.node.jsBlock)
                }
            }
        case blockCategory:
            if contact.bodyB.categoryBitMask == ballCategory {
                let ball = contact.bodyB.node?.entity as! BallEntity
                let block = contact.bodyA.node?.entity as! BlockEntity
                block.crash(ball: ball)
                if block.isDead {
                    block.destroy()
                    self.delegate?.destroyedBlock(jsBlock: block.node.jsBlock)
                }
            }
        default:
            break
        }
    }

    let stageRect: CGRect
    let playScene: PlayScene
    let padleEntity: PadleEntity
    let ballEntity: BallEntity
    var blockEntities: [BlockEntity]
    let spriteComponentSystem: GKComponentSystem<SpriteComponent>
    let moveComponentSystem: GKComponentSystem<MoveComponent>
    let lifeComponentSystem: GKComponentSystem<LifeComponent>
    var delegate: WebrickGameDelegate?
}
