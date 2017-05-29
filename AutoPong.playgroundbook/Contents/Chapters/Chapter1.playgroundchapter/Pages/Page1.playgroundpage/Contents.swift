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
 ## So, what is the exercise?
 Simple! Make all the paddles move!
 > Below, you have the same code from the last page, but now it's fully editable. Careful! With great power, comes great responsibility.
 Hint: Check the code completion
 */
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, topPaddle, rightPaddle, bottomPaddle, leftPaddle)
//#-code-completion(keyword, show, .)
//#-code-completion(bookauxiliarymodule, show, PaddleNode.moveRight(by:), PaddleNode.moveLeft(by:))
spawnBalls(quantity: 1)

var timePassed = 0.0

update {
    dt in
    //#-code-completion(identifier, show, dt)
    
    timePassed += dt
    
    if timePassed <= 2.0 {
        bottomPaddle.moveRight(by: dt*300)
    } else {
        bottomPaddle.moveLeft(by: dt*300)
    }
    
    if timePassed > 4.0 { timePassed = 0.0 }
}
/*:
 > To proceed and take a look at the solution, move to the **Next Page**!
 */
