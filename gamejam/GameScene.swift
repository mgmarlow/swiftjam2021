import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var entityManager: EntityManager?
    var lastUpdateTimeInterval: TimeInterval = 0
    
    override func didMove(to view: SKView) {
        entityManager = EntityManager(scene: self)
        Level().loadLevel(entityManager!)
    }
    
    override func keyDown(with event: NSEvent) {
        entityManager?.handleKeyDown(event)
    }
    
    override func update(_ currentTime: TimeInterval) {
        let deltaTime = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        entityManager?.update(deltaTime)
    }
}
