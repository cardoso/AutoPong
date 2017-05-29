import Foundation
import SpriteKit

class CornerNode: TiledNode {
    
    let tileTexture = SKTexture(image: #imageLiteral(resourceName: "corner_tile.png"))
    
    init() {
        
        super.init(withTileSize: tileTexture.size())

        setupTiles()
    }
    
    
    private func setupTiles() {
        var nodes = [SKSpriteNode]()
        for _ in 0..<5 {
            let node = SKSpriteNode(texture: tileTexture)
            let physicBody = SKPhysicsBody(rectangleOf: tileTexture.size())
            node.physicsBody = physicBody
            node.physicsBody?.categoryBitMask = CategoryBitmasks.corner.rawValue
            node.physicsBody?.collisionBitMask = CategoryBitmasks.ball.rawValue
            node.physicsBody?.affectedByGravity = false
            node.physicsBody?.isDynamic = false
            nodes.append(node)
        }
        
        addChild(nodes[0], atPosition: CGPoint(x: 0, y: 0))
        addChild(nodes[1], atPosition: CGPoint(x: 0, y: 1))
        addChild(nodes[2], atPosition: CGPoint(x: 1, y: 0))
        addChild(nodes[3], atPosition: CGPoint(x: 2, y: 0))
        addChild(nodes[4], atPosition: CGPoint(x: 0, y: 2))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

