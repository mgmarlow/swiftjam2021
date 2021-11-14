import GameplayKit
import SpriteKit

struct Point {
    var x: Int = 0, y: Int = 0
    static var zero: Point = Point(x: 0, y: 0)
}

class MoveComponent: GKComponent {
    let size: CGSize
    var position: Point = .zero
    var cgPosition: CGPoint {
        return CGPoint(
            x: CGFloat(self.position.x) * self.size.width,
            y: CGFloat(self.position.y) * self.size.height
        )
    }
    
    init(pX: Int, pY: Int, size: CGSize) {
        position = Point(
            x: pX / Int(size.width),
            y: pY / Int(size.height)
        )
        self.size = size
        super.init()
    }
    
    required init(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func move(_ cnext: Point) {
        position = Point(x: position.x + cnext.x, y: position.y + cnext.y)
    }
    
    func handleKeyDown(_ event: NSEvent) {
        switch event.keyCode {
        case 13: // w
            move(Point(x: 0, y: 1))
        case 1: // s
            move(Point(x: 0, y: -1))
        case 0: // a
            move(Point(x: -1, y: 0))
        case 2: // d
            move(Point(x: 1, y: 0))
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
    
    // Keep sprite pixel position in sync with coordinates
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        guard let spriteCmp = entity?.component(ofType: SpriteComponent.self) else {
            return
        }
        
        spriteCmp.node.position = cgPosition
    }
}
