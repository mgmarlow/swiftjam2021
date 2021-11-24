import Foundation
import GameplayKit

class TagComponent: GKComponent {
    let tag: String
    
    init(_ tag: String) {
        self.tag = tag
        super.init()
    }
    
    required init(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
