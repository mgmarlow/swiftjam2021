import SpriteKit
import GameplayKit

class Player: GKEntity {
    init(x: Int, y: Int) {
        super.init()
        let texture = SKTexture(imageNamed: "player")
        let cx = x / Int(texture.size().width)
        let cy = y / Int(texture.size().height)
        
        addComponent(SpriteComponent(texture: texture))
        addComponent(PositionComponent(x: cx, y: cy))
        addComponent(MoveComponent())
    }
    
    required init(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
