//
//  NPC.swift
//  TEsteAudio
//
//  Created by Josivan Marques on 23/04/22.
//
///
///
///
///



import SpriteKit

public class NPC: SKNode {
    public override init() {
        super.init()
        
        let npc = SKSpriteNode(imageNamed: "police1")
        npc.texture?.filteringMode = .nearest
        npc.setScale( 0.5)
        self.addChild(npc)
        
        npc.run(.repeatForever(.animate(with: .init(withFormat: "police%@", range: 1...2), timePerFrame: 0.5)))

        // BALLON

        let balloon = SKSpriteNode(imageNamed: "talk_balloon")
        balloon.texture?.filteringMode = .nearest
        balloon.position.y = npc.size.height / 2 + 5
        balloon.run(.repeatForever(.sequence([
            .group([
                .moveBy(x: 0, y: 4, duration: 0.2),
                .scale(to: 1.1, duration: 0.6)
            ]),
            .group([
                .moveBy(x: 0, y: -4, duration: 0.6),
                .scale(to: 1, duration: 0.6)
            ]),
        ])))
        self.addChild(balloon)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
        
    }
}

        

public class RT: SKNode {
    public override init() {
        super.init()
        
        let rt = SKSpriteNode(imageNamed: "NPCScene1")
        rt.texture?.filteringMode = .nearest
        rt.setScale( 0.5)
        self.addChild(rt)
        
        rt.run(.repeatForever(.animate(with: .init(withFormat: "NPCScene%@", range: 1...2), timePerFrame: 0.5)))

        // BALLON

        let balloon = SKSpriteNode(imageNamed: "talk_balloon")
        balloon.texture?.filteringMode = .nearest
        balloon.position.y = rt.size.height / 2 + 5
        balloon.run(.repeatForever(.sequence([
            .group([
                .moveBy(x: 0, y: 4, duration: 0.2),
                .scale(to: 1.1, duration: 0.6)
            ]),
            .group([
                .moveBy(x: 0, y: -4, duration: 0.6),
                .scale(to: 1, duration: 0.6)
            ]),
        ])))
        self.addChild(balloon)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
        
    }
}

        
        
        
        
        
        
        
        
        


        
        
        
        
        
        

