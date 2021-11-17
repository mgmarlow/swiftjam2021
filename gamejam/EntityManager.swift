import Foundation
import GameplayKit
import SpriteKit

class EntityManager {
    var entities = Set<GKEntity>()
    let scene: SKScene
    lazy var moveSystem: GKComponentSystem<MoveComponent> = GKComponentSystem(componentClass: MoveComponent.self)
    lazy var positionSystem: GKComponentSystem<PositionComponent> = GKComponentSystem(componentClass: PositionComponent.self)
    
    init(scene: SKScene) {
        self.scene = scene
    }
    
    func add(_ entity: GKEntity) {
        entities.insert(entity)
        
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            scene.addChild(spriteNode)
        }
        
        moveSystem.addComponent(foundIn: entity)
        positionSystem.addComponent(foundIn: entity)
    }
    
    func remove(_ entity: GKEntity) {
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            spriteNode.removeFromParent()
        }
        
        entities.remove(entity)
    }
    
    func handleKeyDown(_ event: NSEvent) {
        moveSystem.components.forEach({ $0.handleKeyDown(event) })
    }
    
    func update(_ deltaTime: CFTimeInterval) {
        moveSystem.components.forEach({ $0.update(deltaTime: deltaTime) })
        positionSystem.components.forEach({ $0.update(deltaTime: deltaTime) })
    }
}
