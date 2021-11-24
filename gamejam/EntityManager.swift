import Foundation
import GameplayKit
import SpriteKit

class EntityManager {
    var entities = Set<GKEntity>()
    let scene: SKScene
    lazy var positionSystem: GKComponentSystem<PositionComponent> = GKComponentSystem(componentClass: PositionComponent.self)
    
    init(scene: SKScene) {
        self.scene = scene
    }
    
    func add(_ entity: GKEntity) {
        entities.insert(entity)
        
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            scene.addChild(spriteNode)
        }
        
        positionSystem.addComponent(foundIn: entity)
    }
    
    func remove(_ entity: GKEntity) {
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            spriteNode.removeFromParent()
        }
        
        entities.remove(entity)
        positionSystem.removeComponent(foundIn: entity)
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
        positionSystem.components.forEach({ $0.update(deltaTime: deltaTime) })
    }
}
