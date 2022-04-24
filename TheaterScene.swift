//
//  File.swift
//  TEsteAudio
//
//  Created by Josivan Marques on 23/04/22.
////
//

//
//  File.swift
//  amazon
//
//  Created by Josivan Marques on 18/04/22.
//
import Foundation
import SpriteKit


public class TheaterScene: SKScene{

var player:PlayerNode?
var direction: CGFloat = 0
var velocity: CGFloat = 1
    
var urban: (() -> Void)! = nil
var back:(()-> Void)! = nil
    
var canEnterCave: Bool = false
    
var talkNPCButton: SKButtonNode?
var enterCaveButton: SKButtonNode?
var balloon: SKBalloonNode?

    public override func didMove(to view: SKView) {
        
            setupScene()
        urban = {
            let scene = UrbanScene(size: view.bounds.size)
            scene.size = UIScreen.main.bounds.size
            scene.size = CGSize(width: 240, height: 160)
            view.presentScene(scene)
            
        }
        
        back = {
            let scene = GameScene(size: view.bounds.size)
            scene.size = UIScreen.main.bounds.size
            scene.size = CGSize(width: 240, height: 160)
            view.presentScene(scene)
            
        }
        
      
        
        }
        public func setupScene() {
            
            let background = SKSpriteNode(imageNamed: "backTeatroScene")
            background.texture?.filteringMode = .nearest
            background.zPosition = ZPOSITION_BASE - 20
            self.addChild(background)
            
        
            // light
            
            
            
            //Camera
            let camera = SKCameraNode()
            self.addChild(camera)
            self.camera = camera
            let contstraint: SKConstraint = .distance(.init(lowerLimit: -100, upperLimit: 100), to: .zero)
            self.camera?.constraints = [contstraint]
            

            let npc = NPC()
            npc.position.y = -20
            npc.position.x = 90
            npc.zPosition = ZPOSITION_BASE - 1
            self.addChild(npc)
            
            balloon = SKBalloonNode(imageNamed: "pixil-frame-0 (4)")
            balloon?.position.y -= 120
            balloon?.zPosition = ZPOSITION_BASE + 80
            balloon?.setScale(0.4)
            self.camera?.addChild(self.balloon!)
    
            
            
       // MARK: - Buttons
            
            let rightButton = SKButtonNode(imageNamed: "arrow", clickAction: { [weak self] in
                self?.direction = -1
                self?.player?.changeAnimation(to: .walk)
                self?.balloon?.setHide(true)
            }, unclickAction: { [weak self] in
                self?.direction = 0
                self?.player?.changeAnimation(to: .idle)
            })
            rightButton.position = .init(x: -105, y: -55)
            self.camera?.addChild(rightButton)
            
            let leftButton = SKButtonNode(imageNamed: "arrow", clickAction: { [weak self] in
                self?.direction = 1
                self?.player?.changeAnimation(to: .walk)
                self?.balloon?.setHide(true)
            }, unclickAction: { [weak self] in
                self?.direction = 0
                self?.player?.changeAnimation(to: .idle)
            })
            leftButton.position = .init(x: 105, y: -55)
            leftButton.xScale = -1
            self.camera?.addChild(leftButton)
            
            self.talkNPCButton = SKButtonNode(imageNamed: "bt", text: "TALK", clickAction: { [weak self] in
                self?.balloon?.setHide(false)
                // CAN PASS TO NEXT SCENE
                self?.canEnterCave = true
            })
            self.talkNPCButton?.position.y = -70
            self.camera?.addChild(talkNPCButton!)
            

                
            self.player = PlayerNode()
            self.player?.position.y = Y_GROUND
            self.player?.position.x = -150
            self.player?.zPosition = ZPOSITION_BASE
            self.addChild(self.player!)
            
            
            let playerConstraint = SKConstraint.positionX(.init(lowerLimit: -205, upperLimit: 205))
            self.player?.constraints = [playerConstraint]
            
            
            
            self.enterCaveButton = SKButtonNode(imageNamed: "bt", text: "NEXT", clickAction: { [weak self] in
                self?.urban?()
            })
            self.enterCaveButton?.position.y = -70
            self.camera?.addChild(enterCaveButton!)
            
            
            self.enterCaveButton = SKButtonNode(imageNamed: "bt", text: "BACK", clickAction: { [weak self] in
                self?.urban?()
            })
            self.enterCaveButton?.position.y = -70
            self.camera?.addChild(enterCaveButton!)
            
            
        }
        
public override func update(_ currentTime: TimeInterval) {

let cameraBounds = self.frame.width / 2
let bounds = self.calculateAccumulatedFrame().width/2 - cameraBounds

if let positionPlayer = self.player?.position{
    
    if positionPlayer.x < bounds && positionPlayer.x > -(bounds){
        
        cameraFollowPlayer()

        
                }
    }
    
    
    
    if(direction != 0) {
        self.player?.xScale = direction
        self.player?.position.x += self.direction * velocity
    }
    
    if(isNearToNPC()){
        self.talkNPCButton?.run(.unhide())
    } else {
        self.talkNPCButton?.run(.hide())
    }
  
    
    if(isNearToCave() && canEnterCave) {
        self.enterCaveButton?.run(.unhide())
    } else {
        self.enterCaveButton?.run(.hide())
    }
    
    cameraFollowPlayer()
    
            
            
        
     func isNearToNPC() -> Bool {
        guard let player = self.player else {
            return false
        }
        return (player.position.x > 65 && player.position.x < 105)
    }
    
     func isNearToCave() -> Bool {
        guard let player = self.player else {
            return false
        }
        return (player.position.x > 180 && player.position.x < 400)
    }
    
     func cameraFollowPlayer() {
        self.camera?.run(.moveTo(x: self.player?.position.x ?? 0, duration: 0.4))
    }
    
    
}
    
    
    
    
    
    
    
    
    
    
    
    
//
//            var playerAudio: AVAudioPlayer?
//
//            func playSound() {
//                guard let path = Bundle.main.path(forResource: "rowing", ofType:"wav") else {
//                    print("NÃO ACHEI")
//                    return }
//                let url = URL(fileURLWithPath: path)
//
//                do {
//                    playerAudio = try AVAudioPlayer(contentsOf: url)
//                    playerAudio?.play()
//
//                } catch let error {
//                    print(error.localizedDescription)
//                }
//            }
    
    }















//import Foundation
//import SpriteKit
//
//
//public class TheaterScene: SKScene{
//
//var player:PlayerNode?
//var direction: CGFloat = 0
//var velocity: CGFloat = 1
//
//var urban: (() -> Void)! = nil
//
//var canEnterCave: Bool = false
//
//var talkNPCButton: SKButtonNode?
//var enterCaveButton: SKButtonNode?
//var balloon: SKBalloonNode?
//
//    public override func didMove(to view: SKView) {
//
//        urban = {
//            let scene = GameScene(size: view.bounds.size)
//            scene.size = UIScreen.main.bounds.size
//            scene.size = CGSize(width: 240, height: 160)
//            view.presentScene(scene)
//
//        }
//    }
//}
