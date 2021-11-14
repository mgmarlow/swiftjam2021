import SpriteKit

// Heavily modified, but adapted from:
// https://stackoverflow.com/questions/28008107/using-sprite-sheets-in-xcode
// Used to load specific textures from a single spritesheet.
class SpriteSheet {
    let texture: SKTexture
    let rows: Int
    let columns: Int
    let framesize: CGSize
    
    init(texture: SKTexture, rows: Int, columns: Int, framesize: CGSize) {
        self.texture = texture
        self.rows = rows
        self.columns = columns
        self.framesize = framesize
    }
    
    func getTexture(row: Int, column: Int) -> SKTexture? {
        if !(0...self.rows ~= row && 0...self.columns ~= column) {
            //location is out of bounds
            return nil
        }
        
        let x = CGFloat(column) * self.framesize.width
        let y = CGFloat(row) * self.framesize.height
        
        // Values must be between 0 and 1.
        // e.g. (x: 0, y: 0, width: 1, height: 1), which covers the entire texture.
        let textureRect = CGRect(
            x: self.nearest(x / self.texture.size().width),
            y: self.nearest(y / self.texture.size().height),
            width: self.nearest(self.framesize.width / self.texture.size().width),
            height: self.nearest(self.framesize.height / self.texture.size().height)
        )
        
        return SKTexture(rect: textureRect, in: self.texture)
    }
    
    // Round to three decimal places
    func nearest(_ v: CGFloat) -> CGFloat {
        return round(v * 1000) / 1000.0
    }
}
