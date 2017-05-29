//#-hidden-code
import PlaygroundSupport
import SpriteKit

let gameVC = GameViewController()

PlaygroundPage.current.liveView = gameVC

let scene = gameVC.scene
let game = gameVC.scene?.gameArea

func spawnBalls(quantity: UInt) {
    game?.spawnBalls(quantity: quantity)
}

func update(_ block: @escaping (TimeInterval) -> Void) {
    game?.onUpdate = block
}

func paddle(_ location: PaddleLocation) -> PaddleNode {
    return (game?.paddles.filter {
        $0.location == location
        }[0])!
}

let paddles = game!.paddles
let topPaddle = paddle(.top)
let rightPaddle = paddle(.right)
let bottomPaddle = paddle(.bottom)
let leftPaddle = paddle(.left)
var balls: [BallNode] {
    return game!.balls
}

//#-end-hidden-code
/*:
 > This is all the code we have written in this playground so far. This is a good place to experiment 😁
 */
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, topPaddle, rightPaddle, bottomPaddle, leftPaddle)
//#-code-completion(bookauxiliarymodule, show, PaddleNode.moveRight(by:), PaddleNode.moveLeft(by:))
func getNearestBall(to paddle: PaddleNode) -> BallNode {
    
    let nearestBalls = balls.sorted {
        let d1 = paddle.pos.distanceTo($0.pos)
        let d2 = paddle.pos.distanceTo($1.pos)
        return d1 < d2
    }
    
    return nearestBalls[0]
}

func moveBottomPaddle(by: Double) {
    let ball = getNearestBall(to: bottomPaddle)
    
    if(ball.pos.x < bottomPaddle.pos.x) {
        bottomPaddle.moveLeft(by: by)
    }
    
    if(ball.pos.x > bottomPaddle.pos.x) {
        bottomPaddle.moveRight(by: by)
    }
}

func moveTopPaddle(by: Double) {
    let ball = getNearestBall(to: topPaddle)
    
    if(ball.pos.x < topPaddle.pos.x) {
        topPaddle.moveRight(by: by)
    }
    
    if(ball.pos.x > topPaddle.pos.x) {
        topPaddle.moveLeft(by: by)
    }
}

func moveLeftPaddle(by: Double) {
    let ball = getNearestBall(to: leftPaddle)
    
    if(ball.pos.y < leftPaddle.pos.y) {
        leftPaddle.moveRight(by: by)
    }
    
    if(ball.pos.y > leftPaddle.pos.y) {
        leftPaddle.moveLeft(by: by)
    }
}

func moveRightPaddle(by: Double) {
    let ball = getNearestBall(to: rightPaddle)
    
    if(ball.pos.y < rightPaddle.pos.y) {
        rightPaddle.moveLeft(by: by)
    }
    
    if(ball.pos.y > rightPaddle.pos.y) {
        rightPaddle.moveRight(by: by)
    }
}

func paddle(_ paddle: PaddleNode, kickIfBallInRange range: Double) {
    let ball = getNearestBall(to: paddle)
    let dist = Double(ball.pos.distanceTo(paddle.pos))
    
    if(dist < range) {
        paddle.kick()
    }
}

spawnBalls(quantity: 2)

update {
    dt in
    
    moveRightPaddle(by: dt*300)
    moveLeftPaddle(by: dt*300)
    moveTopPaddle(by: dt*300)
    moveBottomPaddle(by: dt*300)
    
    paddle(topPaddle, kickIfBallInRange: 150)
    paddle(rightPaddle, kickIfBallInRange: 150)
    paddle(bottomPaddle, kickIfBallInRange: 150)
    paddle(leftPaddle, kickIfBallInRange: 150)
}
