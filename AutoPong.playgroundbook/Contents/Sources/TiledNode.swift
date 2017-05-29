import Foundation
import SpriteKit

public class TiledNode: SKNode {
    
    let tileSize: CGSize

    init(withTileSize tileSize: CGSize) {
        self.tileSize = tileSize
        super.init()
    }
    
    func addChild(_ node: SKNode, atPosition position: CGPoint) {
        
        self.addChild(node)
        node.position = CGPoint(x: position.x*tileSize.width + tileSize.width/2,
                                y: position.y*tileSize.height + tileSize.height/2)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
