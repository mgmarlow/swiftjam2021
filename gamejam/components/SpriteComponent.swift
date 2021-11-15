import GameplayKit
import SpriteKit

class SpriteComponent: GKComponent {
    let node: SKSpriteNode
    
    init(texture: SKTexture) {
        node = SKSpriteNode(texture: texture, size: texture.size())
        node.anchorPoint = .zero
        super.init()
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
