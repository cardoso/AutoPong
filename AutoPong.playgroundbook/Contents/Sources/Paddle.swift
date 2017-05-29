import Foundation
import SpriteKit

public enum PaddleLocation: Int {
    case bottom = 0
    case top = 1
    case left = 2
    case right = 3
}

public class PaddleNode : TiledNode {
    
    weak var owner: Player?
    
    var sprite: SKSpriteNode!
    var tiles = [SKSpriteNode]()
    var kickNode: KickNode!
    
    var canKick: Bool = true
    
    public var onScore = {}
    public var onScored = {}
    
    public let location: PaddleLocation
    let style: Style
    
    public var pos: CGPoint {
        switch(location) {
        case .bottom:
            return self.position.offseted(dx: self.paddleSize().width/2, dy: 0)
        case .top:
            return self.position.offseted(dx: -self.paddleSize().width/2, dy: 0)
        case .left:
            return self.position.offseted(dx: 0, dy: -self.paddleSize().width/2)
        case .right:
            return self.position.offseted(dx: 0, dy: self.paddleSize().width/2)
        }
    }
    
    init(withLocation location: PaddleLocation, andStyle style: Style) {
        
        self.location = location
        self.style = style
        
        super.init(withTileSize: self.style.tileTexture.size())
        setupTiles(numberOfTiles:3)
        setupKick(withRadius:1.5 * self.style.tileTexture.size().width)
    }
    
    func paddleSize() -> CGSize {
        
        let w = self.tiles.reduce(0) { return $0.0 + $0.1.size.width }
        let h = self.tiles.reduce(0) { return $0.0 + $0.1.size.height }
        
        return CGSize(width: w, height: h)
    }
    
    public func moveLeft(by: Double) {
        if self.canMoveLeft() {
            let dx =  -(CGFloat)(by)
            self.position = self.position.offset(dx: dx*cos(self.zRotation), dy: dx*sin(self.zRotation))
        }
    }
    
    public func moveRight(by: Double) {
        if self.canMoveRight() {
            let dx =  (CGFloat)(by)
            self.position = self.position.offset(dx: dx*cos(self.zRotation), dy: dx*sin(self.zRotation))
        }
    }
    
    func canMoveLeft() -> Bool {
        switch(self.location) {
        case .bottom:
            return self.position.x > -334
        case .top:
            return self.position.x < 334
        case .left:
            return self.position.y < 334
        case .right:
            return self.position.y > -334
        }
    }
    
    func canMoveRight() -> Bool {
        let size = CGFloat(self.tiles.count) * self.tileSize.width
        switch(self.location) {
        case .bottom:
            return self.position.x < 334 - size
        case .top:
            return self.position.x > -334 + size
        case .left:
            return self.position.y > -334 + size
        case .right:
            return self.position.y < 334 - size
        }
    }
    
    func sendToLeft() {
        let size = CGFloat(self.tiles.count) * self.tileSize.width
        switch(self.location) {
        case .bottom:
            self.position.x = -334
        case .top:
            self.position.x = 334
        case .left:
            self.position.y = 334
        case .right:
            self.position.y = -334
        }
    }
    
    func sendToRight() {
        let size = CGFloat(self.tiles.count) * self.tileSize.width
        switch(self.location) {
        case .bottom:
            self.position.x = 334 - size
        case .top:
            self.position.x = -334 + size
        case .left:
            self.position.y = -334 + size
        case .right:
            self.position.y = 334 - size
        }
    }
    
    private func setupKick(withRadius radius:CGFloat) {
        if self.kickNode?.parent != nil {
            self.kickNode.removeFromParent()
        }
        self.kickNode = KickNode(withRadius:radius)
        self.kickNode.zRotation = CGFloat(M_PI_2)
        self.kickNode.position = CGPoint(x:radius, y: self.style.tileTexture.size().height)
        self.kickNode.paddle = self
        self.addChild(self.kickNode)
    }
    
    private func setupTiles(numberOfTiles number:Int) {
        self.tiles.forEach {
            if $0.parent != nil {
                $0.removeFromParent()
            }
        }
        self.tiles.removeAll()
        
        for i in 0..<number {
            let node = SKSpriteNode(texture: self.style.tileTexture)
            addChild(node, atPosition: CGPoint(x: i, y: 0))
            self.tiles.append(node)
        }
        
        let textureSize = self.style.tileTexture.size()
        let size = CGSize(width: textureSize.width*CGFloat(number), height: textureSize.height)
        self.physicsBody = SKPhysicsBody(rectangleOf: size, center: CGPoint(x: size.width/2, y: size.height/2))
        self.physicsBody?.isDynamic = false
    }
    
    public func kick(){
        if self.canKick {
            self.canKick = false
            kickNode.isHidden = false
            
            self.kickNode.enabled = true
            self.kickNode.animateKick()
            
            Timer.after(0.250) {
                self.kickNode.enabled = false
                self.canKick = true
                }.start()
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PaddleNode: Updatable {
    
    func update(_ currentTime: TimeInterval, _ deltaTime: TimeInterval) {
        
        if !self.canMoveLeft() {
            sendToLeft()
        }
        
        if !self.canMoveRight() {
            sendToRight()
        }
    }
}
