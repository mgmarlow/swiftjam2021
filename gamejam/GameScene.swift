import SpriteKit
import GameplayKit

protocol GameObject {
    func handleKeyDown(_ event: NSEvent) -> Void
}

class GameScene: SKScene {
    var spritesheet: SpriteSheet?
    var entities: [GameObject] = []
    var levelLoader: TilemapLoader?
    
    private var player: Player?
    
    // Prefer sceneDidLoad or didMove for initialization? Original uses didMove.
    override func sceneDidLoad() {
        // Load a spritesheet into memory that all entities will use to create textures.
        self.spritesheet = SpriteSheet(
            texture: SKTexture(imageNamed: "spritesheet"),
            rows: 8,
            columns: 13,
            framesize: CGSize(width: 64, height: 64)
        )
        
        self.levelLoader = TilemapLoader(fileNamed: "level_1")
        self.levelLoader!.forEachLayer(self.createEntities)
    }
    
    override func keyDown(with event: NSEvent) {
        self.entities.forEach({ e in
            e.handleKeyDown(event)
        })
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func createEntities(l: Layer) {
        if (l.name == "entities") {
            // Since we know this is an object layer, let's ignore the Optional
            l.objects!.forEach({ (obj: Object) in
                if let entity = self.getEntityFromObject(obj) {
                    self.addChild(entity)
                    self.entities.append(entity)
                }
            })
        }
    }
    
    func getEntityFromObject(_ obj: Object) -> Entity? {
        let tileIndex = obj.gid - 1
        let tilemap = self.levelLoader!.tilemap!
        // Correct Y coordinate due to SpriteKit's bottom-left origin
        let correctedY = tilemap.height * tilemap.tileheight - obj.y
        
        switch obj.name {
        // We'll probably pass this through as default, and lookup entity-specific properties
        // based on the entity name in a separate class.
        case "roach", "simple_trap":
            let entity = Entity(self, size: CGSize(width: 64, height: 64), tileIndex: tileIndex)
            // TODO: implement as entity#setPositionFromPx to create cx, cy (from player class)
            entity.name = obj.name
            entity.position.x = CGFloat(obj.x)
            entity.position.y = CGFloat(correctedY)
            entity.anchorPoint = .zero
            return entity
        case "player":
            return Player(self, x: obj.x, y: correctedY, tileIndex: 65)
        default:
            print("unhandled obj: \(obj.name)")
        }
        
        return nil
    }
}
