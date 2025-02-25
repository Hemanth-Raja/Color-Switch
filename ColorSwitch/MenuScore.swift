//
//  MenuScore.swift
//  ColorSwitch
//
//  Created by Hemanth Raja on 26/08/18.
//  Copyright © 2018 Hemanth Raja. All rights reserved.
//

import SpriteKit

class MenuScore: SKScene {

    override func didMove(to view: SKView) {
        backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
        addLogo()
        addLabel()
        
    }
    
    func addLogo(){
        let logo = SKSpriteNode(imageNamed: "logo")
        logo.size = CGSize(width: frame.size.width/4, height: frame.size.width/4)
        logo.position = CGPoint(x: frame.midX, y: frame.midY + frame.size.height/4)
        addChild(logo)
        
    }
    
    func addLabel(){
        let playlabel = SKLabelNode(text: "Tap to Play!")
        playlabel.fontName = "AvenirNext-Bold"
        playlabel.fontColor = UIColor.white
        playlabel.fontSize = 50.0
        playlabel.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(playlabel)
        animate(label: playlabel)
        
        let highscorelabel = SKLabelNode(text: "HighScore:" + "\(UserDefaults.standard.integer(forKey: "HighScore"))")
        highscorelabel.fontName = "AvenirNext-Bold"
        highscorelabel.fontColor = UIColor.white
        highscorelabel.fontSize = 40.0
        highscorelabel.position = CGPoint(x: frame.midX, y: frame.midY - highscorelabel.frame.size.height*4)
        addChild(highscorelabel)
        
        let recentscorelabel = SKLabelNode(text: "Recent Score:" + "\(UserDefaults.standard.integer(forKey: "RecentScore"))")
        recentscorelabel.fontName = "AvenirNext-Bold"
        recentscorelabel.fontColor = UIColor.white
        recentscorelabel.fontSize = 40.0
        recentscorelabel.position = CGPoint(x: frame.midX, y: highscorelabel.position.y - recentscorelabel.frame.size.height*2)
        addChild(recentscorelabel)
        
        }
    
    func animate(label:SKLabelNode){
        //let fadeOut = SKAction.fadeOut(withDuration: 0.5)
       // let fadeIn = SKAction.fadeOut(withDuration: 0.5)
        let scaleUp = SKAction.scale(to: 1.2, duration: 0.5)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.5)
        let sequnce = SKAction.sequence([scaleUp, scaleDown])
        label.run(SKAction.repeatForever(sequnce))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let gameScene = GameScene(size: view!.bounds.size)
        view!.presentScene(gameScene)
        
    }
}
