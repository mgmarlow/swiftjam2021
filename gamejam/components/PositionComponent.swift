import Foundation
import GameplayKit

struct Point {
    var x: Int = 0, y: Int = 0
    static var zero: Point = Point(x: 0, y: 0)
}

class PositionComponent: GKComponent {
    var position: Point = .zero

    init(x: Int = 0, y: Int = 0) {
        position = Point(x: x, y: y)
        super.init()
    }
    
    override func didAddToEntity() {
        updateSprite()
    }
    
    required init(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPosition(x: Int, y: Int) {
        position = Point(x: x, y: y)
        updateSprite()
    }
    
    func move(_ dir: Point) {
        let nextPosition = Point(x: position.x + dir.x, y: position.y + dir.y)
        moveTo(nextPosition)
    }
    
    func moveTo(_ p: Point) {
        setPosition(x: p.x, y: p.y)
    }
    
    // Keep sprite x/y in sync with coordinate position.
    func updateSprite() {
        guard let spriteCmp = entity?.component(ofType: SpriteComponent.self) else {
            return
        }
        
        spriteCmp.node.position.x = CGFloat(position.x) * spriteCmp.node.size.width
        spriteCmp.node.position.y = CGFloat(position.y) * spriteCmp.node.size.height
    }
}
