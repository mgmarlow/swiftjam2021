import Foundation
import GameplayKit

// GameplayKit encourages placing logic in components, which is a little
// different from traditional "pure" ECS.
class InputComponent: GKComponent {
    func handleKeyDown(_ event: NSEvent, positionSystem: GKComponentSystem<PositionComponent>) {
        var dir: Point? = nil
        
        switch event.keyCode {
        case 126: // up
            dir = Point(x: 0, y: 1)
        case 125: // down
            dir = Point(x: 0, y: -1)
        case 124: // right
            dir = Point(x: 1, y: 0)
        case 123: // left
            dir = Point(x: -1, y: 0)
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
        
        if dir == nil {
            return
        }
    
        tryMove(dir!, positionSystem)
    }
    
    func tryMove(_ dir: Point, _ positionSystem: GKComponentSystem<PositionComponent>) {
        guard let posCmp = entity?.component(ofType: PositionComponent.self) else {
            return
        }
        
        let next = Point(x: posCmp.position.x + dir.x, y: posCmp.position.y + dir.y)
        
        if isValid(next: next) {
            posCmp.move(dir)
        }
    }
    
    func isValid(next: Point) -> Bool {
        if (next.x < 0 || next.x >= 8 || next.y < 0 || next.y >= 8) {
            return false
        }
        
        return true
    }
}
