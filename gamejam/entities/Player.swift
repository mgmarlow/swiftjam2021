import SpriteKit
import GameplayKit

class Player: GKEntity {
    init(x: Int, y: Int) {
        super.init()
        let texture = SKTexture(imageNamed: "player")
        addComponent(SpriteComponent(texture: texture))
        addComponent(PositionComponent(x: x, y: y))
        addComponent(TagComponent("player"))
        addComponent(InputComponent())
    }
    
    required init(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
