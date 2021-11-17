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
    
    required init(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPosition(x: Int, y: Int) {
        position = Point(x: x, y: y)
    }
    
    func move(_ cnext: Point) {
        setPosition(x: position.x + cnext.x, y: position.y + cnext.y)
    }
}
