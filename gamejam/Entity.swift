import Foundation
import SpriteKit

enum EntityError: Error {
    case spriteSheetNotFound
}

class Entity: SKSpriteNode, GameObject {
    init(_ scene: GameScene, size: CGSize, tileIndex: Int) {
        let texture = Entity.getTexture(sheet: scene.spritesheet, tileIndex: tileIndex)
        super.init(texture: texture, color: NSColor.clear, size: size)
    }
    
    required init(coder decoder: NSCoder) {
        super.init(coder: decoder)!
    }
    
    static func getTexture(sheet: SpriteSheet?, tileIndex: Int) -> SKTexture? {
        let (row, col) = Entity.getCoordFromTileIndex(tileIndex)
        return sheet?.getTexture(row: row, column: col)
    }
    
    // tilesheet indices: 0-103, tilesheet dimensions: 8x13
    static func getCoordFromTileIndex(_ tileIndex: Int) -> (Int, Int) {
        let row = tileIndex / 13
        let col = tileIndex % 13
        return (row, col)
    }
    
    func handleKeyDown(_ event: NSEvent) {
        // disregard
    }
}
