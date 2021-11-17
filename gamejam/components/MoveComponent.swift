import GameplayKit
import SpriteKit

class MoveComponent: GKComponent {
    func handleMove(_ cnext: Point) {
        guard let positionCmp = entity?.component(ofType: PositionComponent.self) else {
            return
        }
        
        positionCmp.move(cnext)
    }
    
    func handleKeyDown(_ event: NSEvent) {
        switch event.keyCode {
        case 13: // w
            handleMove(Point(x: 0, y: 1))
        case 1: // s
            handleMove(Point(x: 0, y: -1))
        case 0: // a
            handleMove(Point(x: -1, y: 0))
        case 2: // d
            handleMove(Point(x: 1, y: 0))
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
}
