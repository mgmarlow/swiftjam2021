import Foundation
import GameplayKit
import SpriteKit

class InputSystem: GKComponentSystem<GKComponent> {
    func handleKeyDown(_ event: NSEvent) {
        components.forEach({ (component: GKComponent) in
            (component as! InputComponent).handleKeyDown(event)
        })
    }
}

class EntityManager {
    let scene: SKScene
    
    var entities = Set<GKEntity>()
    var toRemove = Set<GKEntity>()

    lazy var inputSystem = InputSystem(componentClass: InputComponent.self)
    lazy var systems: [GKComponentSystem<GKComponent>] = [inputSystem]
    
    init(scene: SKScene) {
        self.scene = scene
    }
    
    func add(_ entity: GKEntity) {
        entities.insert(entity)
        
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            scene.addChild(spriteNode)
        }
        
        systems.forEach({ $0.addComponent(foundIn: entity) })
    }
    
    func remove(_ entity: GKEntity) {
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            spriteNode.removeFromParent()
        }
        
        entities.remove(entity)
        // Need to clean up our component systems as well, but after they update:
        toRemove.insert(entity)
    }
    
    func handleKeyDown(_ event: NSEvent) {
        inputSystem.handleKeyDown(event)
    }
    
    func update(_ deltaTime: CFTimeInterval) {
        for removal in toRemove {
            systems.forEach({ $0.removeComponent(foundIn: removal) })
        }
        toRemove.removeAll()
    }
}
