import SpriteKit
import GameplayKit

protocol GameObject {
    func handleKeyDown(_ event: NSEvent) -> Void
}

class GameScene: SKScene {
    var levelLoader: TilemapLoader?
    var entityManager: EntityManager?
    var lastUpdateTimeInterval: TimeInterval = 0
    
    override func didMove(to view: SKView) {
        entityManager = EntityManager(scene: self)
        levelLoader = TilemapLoader(fileNamed: "level_1")
        
        let tilemap = levelLoader!.createTilemapNode()
        tilemap.anchorPoint = .zero
        addChild(tilemap)
        levelLoader?.forEachEntity(createEntities)
    }
    
    override func keyDown(with event: NSEvent) {
        entityManager?.handleKeyDown(event)
    }
    
    override func update(_ currentTime: TimeInterval) {
        let deltaTime = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        entityManager?.update(deltaTime)
    }
    
    func createEntities(obj: Object) {
        if let entity = getEntityFromObject(obj) {
            entityManager?.add(entity)
        }
    }
    
    func getEntityFromObject(_ obj: Object) -> GKEntity? {
        let tilemap = levelLoader!.tilemap!
        // Correct Y coordinate due to SpriteKit's bottom-left origin
        let correctedY = tilemap.height * tilemap.tileheight - obj.y

        switch obj.name {
        case "roach", "simple_trap":
            // TODO: Move these into their own object classes
            let entity = GKEntity()
            entity.addComponent(SpriteComponent(texture: SKTexture(imageNamed: obj.name)))
            entity.addComponent(PositionComponent(x: obj.x / 64, y: correctedY / 64))
            return entity
        case "player":
            return Player(x: obj.x, y: correctedY)
        default:
            print("unhandled obj: \(obj.name)")
        }

        return nil
    }
}
