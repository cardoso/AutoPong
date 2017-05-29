import Foundation
import SpriteKit

class KickNode : SKNode {
    
    weak var paddle: PaddleNode?
    var sprite: SKSpriteNode!
    var animation: SKAction?
    var enabled: Bool = false
    
    var radius: CGFloat = 30.0 {
        didSet {
            setupSprite()
            setupPhysicsBody()
        }
    }
    
    init(withRadius radius:CGFloat) {
        super.init()
        self.radius = radius
        setupSprite()
        setupPhysicsBody()
    }
    
    private func setupSprite(){
        let texture = SKTexture(imageNamed: "kick_1")
        self.sprite = SKSpriteNode(texture: texture)
        self.sprite.alpha = 0.0
        self.sprite.anchorPoint = CGPoint(x: 0.5, y: 0)
        
        self.sprite.zRotation = -CGFloat(M_PI_2)
        self.addChild(self.sprite)
    }
    
    private func setupPhysicsBody() {
        
        let bezier =  UIBezierPath(arcCenter: CGPoint(x:0.0,y:0.0), radius: radius, startAngle: CGFloat(M_PI_2), endAngle: CGFloat(-M_PI_2), clockwise: false)
        let halfCirclePath = bezier.cgPath
        self.physicsBody = SKPhysicsBody(polygonFrom:halfCirclePath)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = CategoryBitmasks.kick.rawValue
        self.physicsBody?.collisionBitMask = CollisionBitmasks.none.rawValue
        self.physicsBody?.contactTestBitMask = CategoryBitmasks.ball.rawValue | CategoryBitmasks.kick.rawValue
    }
    
    func animateKick() {
        var sprites = [SKTexture]()
        for i in 1...5 {
            let string = "kick_\(i)"
            let sprite = SKTexture(imageNamed: string)
            sprites.append(sprite)
        }
        let animation = SKAction.animate(with: sprites, timePerFrame: 0.1,resize: true, restore: false)
        let appear = SKAction.fadeIn(withDuration: 0.05)
        let disappear = SKAction.fadeOut(withDuration: 0.05)
        self.sprite.run(SKAction.sequence([appear,animation,disappear]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
