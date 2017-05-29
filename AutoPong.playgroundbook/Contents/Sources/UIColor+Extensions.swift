import Foundation
import UIKit
public extension UIColor{
    convenience init(r:CGFloat,g:CGFloat,b:CGFloat,alpha:CGFloat){
        self.init(red: r/255, green: g/255, blue: b/255, alpha: alpha)
    }
}
