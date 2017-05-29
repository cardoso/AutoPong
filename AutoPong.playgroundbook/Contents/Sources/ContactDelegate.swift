import Foundation
import SpriteKit

protocol ContactDelegate {
    func didBeginContact(_ contact: SKPhysicsContact)
    func didEndContact(_ contact: SKPhysicsContact)
}

extension ContactDelegate {
    func didBeginContact(_ contact: SKPhysicsContact) { }
    func didEndContact(_ contact: SKPhysicsContact) { }
}
