//
//  SKBallonNode.swift
//  TEsteAudio
//
//  Created by Josivan Marques on 23/04/22.
//

import Foundation
//
//  File.swift
//  amazon
//
//  Created by Josivan Marques on 20/04/22.
//

import Foundation

import SpriteKit

public class SKBalloonNode: SKNode {

    var background: SKSpriteNode
    var label: SKLabelNode

    init(imageNamed: String) {
        self.background = SKSpriteNode(imageNamed: imageNamed)
        self.label = SKLabelNode(text: "")

        super.init()

        self.background.texture?.filteringMode = .nearest
        self.background.zPosition = -1

        self.addChild(background)
        self.addChild(label)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func change(text: String) {
        self.label.text = text
    }

    public func setHide(_ value: Bool) {
        if(value) {
            self.run(.sequence([
                .moveTo(y: -200, duration: 0.8),
                .hide()
            ]))
        } else {
            self.run(.sequence([
                .unhide(),
                .moveTo(y: 10, duration: 0.8),
            ]))
        }
    }

}
