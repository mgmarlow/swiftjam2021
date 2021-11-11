import SpriteKit
import GameplayKit

class Player: SKSpriteNode {
    static func create(_ scene: GameScene) -> Player {
        let image = scene.spritesheet?.getTexture(row: 4, column: 0)
        let player = Player(texture: image)
        // Using .nearest for pixel art
        player.texture?.filteringMode = .nearest
        player.scale(to: CGSize(width: 64, height: 64))
        player.anchorPoint = .zero
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
