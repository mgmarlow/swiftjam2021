import Foundation
import GameplayKit
import SpriteKit

class EntityManager {
    let scene: SKScene
    
    var entities = Set<GKEntity>()
    var toRemove = Set<GKEntity>()

    lazy var tags = GKComponentSystem(componentClass: TagComponent.self)
    lazy var positionSystem = GKComponentSystem(componentClass: PositionComponent.self)
    lazy var systems: [GKComponentSystem<GKComponent>] = [tags, positionSystem]
    
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
        let player = getBy(tag: "player")
        
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
    
    func getBy(tag: String) -> GKEntity? {
        for comp in tags.components {
            if ((comp as! TagComponent).tag == tag) {
                return comp.entity
            }
        }
        
        return nil
    }
    
    func update(_ deltaTime: CFTimeInterval) {
        for removal in toRemove {
            systems.forEach({ $0.removeComponent(foundIn: removal) })
        }
        toRemove.removeAll()
    }
}
