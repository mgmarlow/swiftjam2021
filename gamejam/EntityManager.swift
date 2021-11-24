import Foundation
import GameplayKit
import SpriteKit

class EntityManager {
    let scene: SKScene
    
    var entities = Set<GKEntity>()
    var toRemove = Set<GKEntity>()
    // Add component systems that need to update here
    lazy var systems: [GKComponentSystem] = {
        return []
    }()
    
    init(scene: SKScene) {
        self.scene = scene
    }
    
    func add(_ entity: GKEntity) {
        entities.insert(entity)
        
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            scene.addChild(spriteNode)
        }
        
        for system in systems {
            system.addComponent(foundIn: entity)
        }
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
        let player = entities.first(where: { (entity: GKEntity) in
            guard let tagCmp = entity.component(ofType: TagComponent.self) else {
                return false
            }
            
            return tagCmp.tag == "player"
        })
        
        switch event.keyCode {
        case 126: // up
            if let posCmp = player?.component(ofType: PositionComponent.self) {
                posCmp.move(Point(x: 0, y: 1))
            }
        case 125: // down
            if let posCmp = player?.component(ofType: PositionComponent.self) {
                posCmp.move(Point(x: 0, y: -1))
            }
        case 124: // right
            if let posCmp = player?.component(ofType: PositionComponent.self) {
                posCmp.move(Point(x: 1, y: 0))
            }
        case 123: // left
            if let posCmp = player?.component(ofType: PositionComponent.self) {
                posCmp.move(Point(x: -1, y: 0))
            }
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
    
    func update(_ deltaTime: CFTimeInterval) {
        for system in systems {
            system.components.forEach({ $0.update(deltaTime: deltaTime) })
        }
        
        for removal in toRemove {
            for system in systems {
                system.removeComponent(foundIn: removal)
            }
        }
        toRemove.removeAll()
    }
}
