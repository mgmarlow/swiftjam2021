import Foundation
import GameplayKit

class Level {
    let level1 = """
    WWWWWWWW
    W......W
    W.R....W
    W......W
    W...X..W
    W.P....W
    W......W
    WWWWWWWW
    """
    
    func loadLevel(_ entityManager: EntityManager) {
        let rows = level1.split(separator: "\n")
        rows.enumerated().forEach({ (rowIndex, row) in
            let y = rows.count - rowIndex - 1
            
            row.enumerated().forEach({ (colIndex, char) in
                guard let entity = getEntity(char, x: colIndex, y: y) else {
                    return
                }
                
                entityManager.add(entity)
            })
        })
    }
    
    func getEntity(_ char: Character, x: Int, y: Int) -> GKEntity? {
        switch (char) {
        case "X":
            let trap = GKEntity()
            trap.addComponent(SpriteComponent(texture: SKTexture(imageNamed: "simple_trap")))
            trap.addComponent(PositionComponent(x: x, y: y))
            return trap
        case "R":
            let roach = GKEntity()
            roach.addComponent(SpriteComponent(texture: SKTexture(imageNamed: "roach")))
            roach.addComponent(PositionComponent(x: x, y: y))
            return roach
        case "P":
            return Player(x: x, y: y)
        default:
            return nil
        }
    }
}
