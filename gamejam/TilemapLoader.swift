import Foundation
import SpriteKit

struct Object: Codable {
    var id: Int
    var gid: Int
    var name: String
    var type: String
    var visible: Bool
    var rotation: Int
    var width: Int
    var height: Int
    var x: Int
    var y: Int
}

struct Tileset: Codable {
    var firstgid: Int
    var source: String
}

struct Layer: Codable {
    var id: Int
    var x: Int
    var y: Int
    var visible: Bool
    var name: String
    var opacity: Int
    var type: String
    // type="tilelayer" only
    var data: [Int]?
    var height: Int?
    var width: Int?
    // type="objectgroup" only
    var draworder: String?
    var objects: [Object]?
}

struct Tilemap: Codable {
    var compressionlevel: Int
    var height: Int
    var infinite: Bool
    var nextlayerid: Int
    var nextobjectid: Int
    var orientation: String
    var renderorder: String
    var tiledversion: String
    var tilewidth: Int
    var tileheight: Int
    var width: Int
    var type: String
    var tilesets: [Tileset]
    var layers: [Layer]
}

enum TilemapError: Error {
    case fileReadError
    case serializationError
}

class TilemapLoader {
    var fileName: String
    var tilemap: Tilemap?
    
    init(fileNamed: String) {
        self.fileName = fileNamed
        self.tilemap = try? loadJson()
    }
    
    func createTilemapNode() -> SKTileMapNode {
        // TODO: Read this off the data array
        let tileIndex = 89
        let texture = SKTexture(imageNamed: "tile_\(tileIndex)")

        // Create the tileset
        let tilesize = CGSize(width: 64, height: 64)
        let definition = SKTileDefinition(texture: texture, size: tilesize)
        let tilegroup = SKTileGroup(tileDefinition: definition)
        let tileset = SKTileSet(tileGroups: [tilegroup], tileSetType: .grid)
        
        let node = SKTileMapNode(
            tileSet: tileset,
            columns: self.tilemap!.width,
            rows: self.tilemap!.height,
            tileSize: CGSize(width: self.tilemap!.tilewidth, height: self.tilemap!.tileheight),
            fillWith: tilegroup
        )
        node.anchorPoint = .zero
        
        return node
    }
    
    func forEachEntity(_ handleCreateEntity: (Object) -> Void) {
        if let tilemap = self.tilemap {
            tilemap.layers.forEach({ (l: Layer) in
                if (l.name == "entities") {
                    l.objects!.forEach(handleCreateEntity)
                }
            })
        }
    }
    
    func loadJson() throws -> Tilemap {
        do {
            if let path = Bundle.main.path(forResource: self.fileName, ofType: "json") {
                if let data = NSData(contentsOfFile: path) {
                    let decoder = JSONDecoder()
                    return try decoder.decode(Tilemap.self, from: Data(data))
                }
            }
            
            throw TilemapError.fileReadError
        } catch {
            throw TilemapError.serializationError
        }
    }
}
