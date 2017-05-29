import Foundation

protocol GoalDelegate {
    
    func goal(_ goal: GoalNode, didReceiveBall ball: BallNode)
}

extension GoalDelegate {
    
    func goal(_ goal: GoalNode, didReceiveBall ball: BallNode) { }
}
