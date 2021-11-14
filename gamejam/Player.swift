import SpriteKit
import GameplayKit

class Player: Entity {
    var cx: Int = 0
    var cy: Int = 0
    
    init(_ scene: GameScene, x: Int, y: Int, tileIndex: Int) {
        super.init(scene, size: CGSize(width: 64, height: 64), tileIndex: tileIndex)
        self.name = "player"
        self.anchorPoint = .zero
        self.setPositionFromPx(x: x, y: y)
    }
    
    required init(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    func setPositionFromPx(x: Int, y: Int) {
        self.cx = Int(x / Int(self.size.width))
        self.cy = Int(y / Int(self.size.height))
        self.setPosition(cx: cx, cy: cy)
    }
    
    func setPosition(cx: Int, cy: Int) {
        self.cx = cx
        self.cy = cy
        self.position.x = CGFloat(cx * Int(self.size.width))
        self.position.y = CGFloat(cy * Int(self.size.height))
    }
    
    func move(x: Int, y: Int) {
        self.setPosition(cx: self.cx + x, cy: self.cy + y)
    }
    
    override func handleKeyDown(_ event: NSEvent) {
        // Note: Spritekit reverses y coordinates against gamedev conventions
        switch event.keyCode {
        case 13: // w
            move(x: 0, y: 1)
        case 1: // s
            move(x: 0, y: -1)
        case 0: // a
            move(x: -1, y: 0)
        case 2: // d
            move(x: 1, y: 0)
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
}
