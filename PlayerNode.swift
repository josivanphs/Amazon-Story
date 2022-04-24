//
//  PlayerNode.swift
//  TEsteAudio
//
//  Created by Josivan Marques on 23/04/22.
//
//
//  PlayerNode.swift
//  amazon
//
//  Created by Josivan Marques on 18/04/22.
//

import Foundation
import SpriteKit

public enum PlayerAnimationState {
    case idle, walk
}

public class PlayerNode:SKNode{
    let sprite: SKSpriteNode
    
    override public init() {
        self.sprite = SKSpriteNode(imageNamed: "respirar1")
        sprite.texture?.filteringMode = .nearest
        sprite.setScale(1)
        super.init()
        self.addChild(sprite)
       changeAnimation(to: .idle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func changeAnimation(to state: PlayerAnimationState) {
            
            switch state {
            case .idle:
                sprite.run(.stop())
                sprite.run(.repeatForever(.animate(with: .init(withFormat: "respirar%@", range: 1...2), timePerFrame: 0.4)))
            case .walk:
                
                sprite.run(.group([
                    .repeatForever(.animate(with: .init(withFormat: "canoa%@", range: 1...5), timePerFrame: 0.1)),
                    .playSoundFileNamed("remo.wav", waitForCompletion: false)
                
                ]))
            break
                
            }
            
            
        }
    
    }

public extension Array where Element == SKTexture {
    init (withFormat format: String, range: ClosedRange<Int>) {
        self = range.map({ (index) in
            let imageNamed = String(
                format: format, "\(index)")
            let texture = SKTexture(imageNamed: imageNamed)
            texture.filteringMode = .nearest
            return texture
        })
    }
}
