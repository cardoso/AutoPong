import Foundation

protocol Updatable {
    func update(_ currentTime: TimeInterval, _ deltaTime: TimeInterval)
}
