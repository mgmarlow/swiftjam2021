import SpriteKit
import GameplayKit

protocol GameObject {
    static func create(_ scene: GameScene, x: Int, y: Int) -> Void
    func handleKeyDown(_ event: NSEvent) -> Void
}

class GameScene: SKScene {
    var spritesheet: SpriteSheet?
    var entities: [GameObject] = []
    
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
        
        let loader = TilemapLoader(fileNamed: "level_1")
        loader.forEachLayer({ (l: Layer) in
            if (l.name == "entities") {
                // Since we know this is an object layer, let's ignore the Optional
                l.objects!.forEach({ (obj: Object) in
                    switch obj.name {
                    case "player":
                        // TODO: Offset Y to fit SpriteKit's coordinate system.
                        Player.create(self, x: obj.x, y: obj.y)
                    default:
                        print("unhandled obj: \(obj.name)")
                    }
                })
            }
        })
    }
    
    override func keyDown(with event: NSEvent) {
        self.entities.forEach({ e in
            e.handleKeyDown(event)
        })
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
