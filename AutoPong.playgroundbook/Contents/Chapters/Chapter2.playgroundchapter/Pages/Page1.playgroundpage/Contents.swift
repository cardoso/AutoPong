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
 ## So, what should i do?
 Easy! Make all the paddles follow the nearest ball!
 > Careful! moveRight and moveLeft will move the paddle relative to its position.
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

spawnBalls(quantity: 2)

update {
    dt in
    
    let ball = getNearestBall(to: bottomPaddle)
    
    if(ball.pos.x < bottomPaddle.pos.x) {
        bottomPaddle.moveLeft(by: dt*300)
    }
    
    if(ball.pos.x > bottomPaddle.pos.x) {
        bottomPaddle.moveRight(by: dt*300)
    }
}
/*:
 > To proceed and take a look at the solution, move to the **Next Page**!
 */
