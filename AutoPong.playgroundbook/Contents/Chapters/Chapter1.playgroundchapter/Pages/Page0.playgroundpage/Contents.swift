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
 ## Come on. Let's move!
 I see you're the "shoot first, ask questions later" type. 
 No problem! Take a look at the explained code below and hit **Run My Code**.
 */
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, topPaddle, rightPaddle, bottomPaddle, leftPaddle)
//: We start by placing a ball inside the game
spawnBalls(quantity: /*#-editable-code*/1/*#-end-editable-code*/)

//: We make a variable to store the time passed
var timePassed = 0.0

//: This is an update loop where ``dt`` is the time between the last and the current frame.
update {
    dt in
    
//: We update ``timePassed``
    timePassed += dt

//: If ``timePassed`` is below 2.0 seconds, we move the ``bottomPaddle`` to the right, otherwise we move it to the left.
    if timePassed <= /*#-editable-code*/2.0/*#-end-editable-code*/ {
//: > It's important that we move the paddles by factors of ``dt``, otherwise they won't move consistently.
        bottomPaddle.moveRight(by: /*#-editable-code*/dt*300/*#-end-editable-code*/)
    } else {
        bottomPaddle.moveLeft(by: /*#-editable-code*/dt*300/*#-end-editable-code*/)
    }
    
//: Reset ``timePassed`` after 4.0 seconds
    if timePassed > /*#-editable-code*/4.0/*#-end-editable-code*/ { timePassed = 0.0 }
}
/*:
 ## That's not a very intelligent AI is it?
 Haha, no it is not. Not yet! But i promise we'll improve on that in the **Next Chapter**.
 Now on to the **Next Page** for an exercise!
 */
