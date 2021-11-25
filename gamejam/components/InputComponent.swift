import Foundation
import GameplayKit

// GameplayKit encourages placing logic in components, which is a little
// different from traditional "pure" ECS.
class InputComponent: GKComponent {
    func handleKeyDown(_ event: NSEvent) {
        switch event.keyCode {
        case 126: // up
            tryMove(Point(x: 0, y: 1))
        case 125: // down
            tryMove(Point(x: 0, y: -1))
        case 124: // right
            tryMove(Point(x: 1, y: 0))
        case 123: // left
            tryMove(Point(x: -1, y: 0))
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
    
    func tryMove(_ dir: Point) {
        guard let posCmp = entity?.component(ofType: PositionComponent.self) else {
            return
        }
        
        posCmp.move(dir)
    }
}
