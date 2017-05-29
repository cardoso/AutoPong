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
 ## So, where's that intelligence you were talking about?
 You'll see! It's really not as complicated as it seems. Take a look at the explained code below then hit **Run My Code** to see the results.
 
 We start out by creating a function to find the nearest ball to a given paddle.
 */
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, paddles, balls, topPaddle, rightPaddle, bottomPaddle, leftPaddle)
func getNearestBall(to paddle: PaddleNode) -> BallNode {
    
    let nearestBalls = balls.sorted {
        let d1 = paddle.pos.distanceTo($0.pos)
        let d2 = paddle.pos.distanceTo($1.pos)
        return d1 < d2
    }

    return nearestBalls[0]
}

/*:
 Now let's spawn a couple balls
 */
spawnBalls(quantity: /*#-editable-code*/2/*#-end-editable-code*/)

/*:
 Do the ol' update loop
 */
update {
    dt in
    
/*:
 Get the nearest ``ball`` to the ``bottomPaddle``.
*/
    let ball = getNearestBall(to: bottomPaddle)
    
/*:
 If the ``ball`` is to the left, move the paddle accordingly.
 */
    if(ball.pos.x < bottomPaddle.pos.x) {
        bottomPaddle.moveLeft(by: /*#-editable-code*/dt*300/*#-end-editable-code*/)
    }
    
/*:
 If the ``ball`` is to the right, move the paddle to the right.
 */
    if(ball.pos.x > bottomPaddle.pos.x) {
        bottomPaddle.moveRight(by: /*#-editable-code*/dt*300/*#-end-editable-code*/)
    }
}
/*:
 Now hit **Run My Code** to see the results!
 */
