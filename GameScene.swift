//
//  File.swift
//  TEsteAudio
//
//  Created by Josivan Marques on 22/04/22.
//
//

import Foundation
import SpriteKit
import AVFoundation

public let Y_GROUND: CGFloat = -50
public let ZPOSITION_BASE: CGFloat = 0


public class GameScene: SKScene{

var player:PlayerNode?
var direction: CGFloat = 0
var velocity: CGFloat = 1
    
var teatro: (() -> Void)! = nil

var canEnterCave: Bool = false
    
var talkNPCButton: SKButtonNode?
var enterTheaterButton: SKButtonNode?
var balloon: SKBalloonNode?

    public override func didMove(to view: SKView) {
        
            setupScene()
        teatro = {
            let scene = TheaterScene (size: view.bounds.size)
            scene.size = UIScreen.main.bounds.size
            scene.size = CGSize(width: 240, height: 160)
            scene.anchorPoint = .init(x: 0.5, y: 0.5)
            scene.scaleMode = .fill
            view.presentScene(scene)
        }
        
      
        
        }
        public func setupScene() {
            
            let background = SKSpriteNode(imageNamed: "GameScene")
            background.texture?.filteringMode = .nearest
            background.zPosition = ZPOSITION_BASE - 20
            self.addChild(background)
            
           // music
            AudioPlayer.playSound(soundPath: "Fluffing a Duck", extentionType: "mp3", loops: -1)
            
            
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
            
            let alligator = SKSpriteNode(imageNamed: "alligator1")
            alligator.position.y = -40
            alligator.position.x = -40
            alligator.setScale(0.5)
            alligator.zPosition = ZPOSITION_BASE - 1
            addChild(alligator)
            
            alligator.run(.repeatForever(.animate(with: .init(withFormat: "alligator%@", range: 1...2), timePerFrame: 0.7)))
            
            // ballon talk
            balloon = SKBalloonNode(imageNamed: "conversetion1")
            balloon?.position.y -= 200
            balloon?.zPosition = ZPOSITION_BASE + 20
            balloon?.setScale(0.6)
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
                self?.canEnterCave = true
            })
            self.talkNPCButton?.position.y = -70
            self.camera?.addChild(talkNPCButton!)
            

                
            self.player = PlayerNode()
            self.player?.position.y = Y_GROUND
            self.player?.zPosition = ZPOSITION_BASE
            self.addChild(self.player!)
            
            let playerConstraint = SKConstraint.positionX(.init(lowerLimit: -200, upperLimit: 200))
            self.player?.constraints = [playerConstraint]
            
            
            self.enterTheaterButton = SKButtonNode(imageNamed: "bt", text: "NEXT", clickAction: { [weak self] in
                self?.teatro?()
            })
            self.enterTheaterButton?.position.y = -70
            self.camera?.addChild(enterTheaterButton!)
            
            
            
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
            self.enterTheaterButton?.run(.unhide())
        } else {
            self.enterTheaterButton?.run(.hide())
    }
    
    cameraFollowPlayer()
    
        // SCENES
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
        return (player.position.x > 180 && player.position.x < 500)
    }
    
     func cameraFollowPlayer() {
        self.camera?.run(.moveTo(x: self.player?.position.x ?? 0, duration: 0.4))
         
         
    }

}
    
    

public class AudioPlayer{
static var audioPlayer: AVAudioPlayer!

static func playSound(soundPath: String, extentionType: String, loops: Int?) {
    
    if let path = Bundle.main.path(forResource: soundPath, ofType: extentionType) {
        do {
        audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
        audioPlayer.numberOfLoops = loops!
        audioPlayer.play()
            
    }
    catch {
        print("cannot play the sound.")
        }
    }
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

