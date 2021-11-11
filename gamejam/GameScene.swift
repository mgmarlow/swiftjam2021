import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var spritesheet: SpriteSheet?
    
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
        self.player = Player.create(self)
    }
    
    override func keyDown(with event: NSEvent) {
        if let p = self.player {
            p.handleKeyDown(event)
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
