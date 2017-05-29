import SpriteKit
import GameplayKit
import GameController
import AVFoundation

public class GameScene: SKScene {
    
    var players: [Player] = []
    public var gameArea: GameAreaNode?
    
    public var onUpdate:((TimeInterval)->Void)? = nil
    public var onLoad = {}
    
    override public func didMove(to view: SKView) {
        self.backgroundColor = UIColor(r: 38, g: 38, b: 38, alpha: 1.0)
        self.setupGameArea()
        
        for (k,v) in ((self.gameArea?.paddles.enumerated()))! {
            v.owner = players[k]
            players[k].paddle = v
        }
        
        for (k,v) in ((self.gameArea?.goals.enumerated()))! {
            v.owner = players[k]
        }
        
        self.physicsWorld.contactDelegate = gameArea
        
        onLoad()
    }
    
    func setupGameArea() {
        let gameAreaSize = CGSize(width: 1024, height: 1024)
        self.gameArea = GameAreaNode(withSize: gameAreaSize)
        self.gameArea?.xScale = 0.5
        self.gameArea?.yScale = 0.5
        addChild(self.gameArea!)
        self.gameArea?.setup()
        self.gameArea?.goals.forEach {$0.delegate = self}
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override public func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        
        
        print(GCController.controllers())
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    private var previousTime: TimeInterval = 0.0
    override public func update(_ currentTime: TimeInterval) {
        
        var deltaTime = currentTime - previousTime
        if(previousTime == 0) { deltaTime = 0 }
        
        self.onUpdate?(deltaTime)
        
        self.children.forEach {
            if let updatable = $0 as? Updatable {
                updatable.update(currentTime, deltaTime)
            }
        }
        
        previousTime = currentTime
    }
}

extension GameScene: GoalDelegate {
    
    func goal(_ goal: GoalNode, didReceiveBall ball: BallNode) {
        
        goal.owner?.score += -25
        goal.owner?.paddle?.onScored()
        
        let isSame = (goal.owner === ball.owner)
        
        ball.owner?.score += isSame ? 0 : 100
        ball.owner?.paddle?.onScore()
    }
}
