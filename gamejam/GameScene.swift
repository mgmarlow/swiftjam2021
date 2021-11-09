//
//  GameScene.swift
//  gamejam
//
//  Created by Graham Marlow on 11/8/21.
//

import SpriteKit
import GameplayKit

class Player: SKSpriteNode {
    static func create(_ scene: SKScene) -> Player {
        let player = Player(color: NSColor.blue, size: NSSize(width: 64, height: 64))
        scene.addChild(player)
        return player
    }
    
    func move(x: Int, y: Int) {
        self.position.x += CGFloat(x * 64)
        self.position.y += CGFloat(y * 64)
    }
    
    func handleKeyDown(_ event: NSEvent) {
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
}

class GameScene: SKScene {
    private var player: Player?
    
    // Prefer sceneDidLoad or didMove for initialization? Original uses didMove.
    override func sceneDidLoad() {
        self.player = Player.create(self)
    }
    
    override func keyDown(with event: NSEvent) {
        if let p = self.player {
            p.handleKeyDown(event)
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
