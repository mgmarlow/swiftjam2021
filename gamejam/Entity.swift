import Foundation
import SpriteKit

enum EntityError: Error {
    case spriteSheetNotFound
}

class Entity: SKSpriteNode, GameObject {
    init(_ scene: GameScene, size: CGSize, imageNamed: String) {
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: NSColor.clear, size: size)
    }
    
    required init(coder decoder: NSCoder) {
        super.init(coder: decoder)!
    }
    
    func handleKeyDown(_ event: NSEvent) {
        // disregard
    }
}
