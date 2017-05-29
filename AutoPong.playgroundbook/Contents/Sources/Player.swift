import Foundation
import UIKit

public class Player {
    
    var score = 0
    
    let style: Style
    var paddle: PaddleNode?
    
    public init(withStyle style: Style = .white) {
        self.style = style
    }
}
