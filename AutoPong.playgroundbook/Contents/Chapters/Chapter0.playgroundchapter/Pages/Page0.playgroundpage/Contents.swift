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

//#-end-hidden-code
/*:
 # AutoPong
 ## So, what is it about?
 Computer controlled players (aka Bots) are an amazing way that video game developers have found to make it possible for you to play multiplayer games when you are by yourself 😁
 But have you ever thought about how they **work behind the scenes**?
 This playground will walk you through the process of creating bots for a feature-packed version of the cultural phenomenon "Pong".
 
 ## Quit the explaining, show me some action!
 Sure! Hit **Run My Code** to see what you've got. */
spawnBalls(quantity: /*#-editable-code*/1/*#-end-editable-code*/)
/*:
 ## Not much going on, eh?
 You probably noticed the paddles are completely oblivious to the ball. That's because there's currently no code telling them what to do. Let's fix that! On to the **Next Chapter**!
 */
