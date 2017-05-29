import Foundation
import SpriteKit

public enum Style: String {
    case white = "white"
    case red = "red"
    case green = "green"
    case blue = "blue"
    case orange = "orange"
    case pink = "pink"
    case purple = "purple"
    
    var tileTexture: SKTexture {
        return SKTexture(imageNamed: "tile_\(self.rawValue)")
    }
    
    var ballTextures: [SKTexture] {
        return (0...3).map {
            return SKTexture(imageNamed: "ball_\(self.rawValue)_\($0)")
        }
    }
}
