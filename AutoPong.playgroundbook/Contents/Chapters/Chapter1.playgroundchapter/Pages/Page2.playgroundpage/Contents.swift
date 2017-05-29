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

let topPaddle = paddle(.top)
let rightPaddle = paddle(.right)
let bottomPaddle = paddle(.bottom)
let leftPaddle = paddle(.left)
//#-end-hidden-code
/*:
> Have you tried solving last page's exercise by yourself? Below is a solution for it.
 Move to the **Next Chapter** when you're ready!
 */
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, topPaddle, rightPaddle, bottomPaddle, leftPaddle)
spawnBalls(quantity: /*#-editable-code*/1/*#-end-editable-code*/)

var timePassed = 0.0

update {
    dt in
    
    timePassed += dt
    
    if timePassed <= /*#-editable-code*/2.0/*#-end-editable-code*/ {
        bottomPaddle.moveRight(by: /*#-editable-code*/dt*300/*#-end-editable-code*/)
        rightPaddle.moveRight(by: /*#-editable-code*/dt*300/*#-end-editable-code*/)
        topPaddle.moveRight(by: /*#-editable-code*/dt*300/*#-end-editable-code*/)
        leftPaddle.moveRight(by: /*#-editable-code*/dt*300/*#-end-editable-code*/)
    } else {
        bottomPaddle.moveLeft(by: /*#-editable-code*/dt*300/*#-end-editable-code*/)
        rightPaddle.moveLeft(by: /*#-editable-code*/dt*300/*#-end-editable-code*/)
        topPaddle.moveLeft(by: /*#-editable-code*/dt*300/*#-end-editable-code*/)
        leftPaddle.moveLeft(by: /*#-editable-code*/dt*300/*#-end-editable-code*/)
    }
    
    if timePassed > /*#-editable-code*/4.0/*#-end-editable-code*/ { timePassed = 0.0 }
}
