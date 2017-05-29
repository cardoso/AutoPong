import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

public class GameViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer?
    var skView: SKView?
    
    public var scene: GameScene? = nil
    
    public var onLayout = {}
    public var onLoad = {}
    
    public init() {
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.skView = SKView(frame: self.view.frame)
        self.view.addSubview(self.skView!)
        
        
        presentGameScene(withPlayers: [Player(withStyle: .blue),
                                       Player(withStyle: .green),
                                       Player(withStyle: .orange),
                                       Player(withStyle: .purple)])
        
        onLoad()
    }
    
    override public func viewDidLayoutSubviews() {
        
        self.skView?.center = self.view.center
        self.skView?.frame = self.view.frame

        self.onLayout()
    }
    
    func presentGameScene(withPlayers players: [Player]) {
        
        if let skView = self.skView {
            
            scene = GameScene(size: CGSize(width: 1920, height: 1080))
            
            scene?.players = players
            
            scene?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            scene?.scaleMode = .aspectFill
            
            skView.presentScene(scene)
            
            skView.ignoresSiblingOrder = true
        }
    }
    
    
    override public func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        for item in presses {
            
        }
    }
    
    override public func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        for item in presses {
            
        }
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
}
