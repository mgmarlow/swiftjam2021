//
//  GameScene.swift
//  gamejam
//
//  Created by Graham Marlow on 11/8/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var player: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        self.player = self.childNode(withName: "//Player") as? SKSpriteNode
    }
    
    func move(x: Int, y: Int) {
        if let p = self.player {
            p.position.x += CGFloat(x * 64)
            p.position.y += CGFloat(y * 64)
        }
    }
    
    override func keyDown(with event: NSEvent) {
        // Note: Spritekit reverses y coordinates against gamedev conventions
        switch event.keyCode {
        case 13: // w
            move(x: 0, y: 1)
        case 1: // s
            move(x: 0, y: -1)
        case 0: // a
            move(x: -1, y: 0)
        case 2: // d
            move(x: 1, y: 0)
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
