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
 > Have you tried solving last page's exercise by yourself? Below is a solution for it.
 Move to the **Next Chapter** when you're ready!
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

spawnBalls(quantity: /*#-editable-code*/2/*#-end-editable-code*/)

update {
    dt in
    
    moveRightPaddle(by: /*#-editable-code*/dt*300/*#-end-editable-code*/)
    moveLeftPaddle(by: /*#-editable-code*/dt*300/*#-end-editable-code*/)
    moveTopPaddle(by: /*#-editable-code*/dt*300/*#-end-editable-code*/)
    moveBottomPaddle(by: /*#-editable-code*/dt*300/*#-end-editable-code*/)
}
