//
//  GameScene.swift
//  ColorSwitch
//
//  Created by Hemanth Raja on 26/08/18.
//  Copyright © 2018 Hemanth Raja. All rights reserved.
//

import SpriteKit
import UIKit

let impactFeedbackGenerator: (
    light: UIImpactFeedbackGenerator,
    medium: UIImpactFeedbackGenerator,
    heavy: UIImpactFeedbackGenerator) = (
        UIImpactFeedbackGenerator(style: .light),
        UIImpactFeedbackGenerator(style: .medium),
        UIImpactFeedbackGenerator(style: .heavy)
)

enum Playcolors {
    static let colors = [
        UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0),
        UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0),
        UIColor(red: 241/255, green: 196/255, blue: 15/255, alpha: 1.0),
        UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
    ]
}

enum Switchstate: Int {
    case red, green, yello, blue
}


class GameScene: SKScene {
    
    var colorSwitch: SKSpriteNode!
    var switchstate = Switchstate.red
    var currentColorIndex: Int?
    let scoreLabel = SKLabelNode(text: "0")
    var score = 0
    
    
    override func didMove(to view: SKView) {
        setphysics()
        layoutScene()
        
        }
    func setphysics(){
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0)
        physicsWorld.contactDelegate = self
    }
    func layoutScene(){
        backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
        colorSwitch = SKSpriteNode(imageNamed: "color")
        colorSwitch.size = CGSize(width: frame.size.width/3, height: frame.size.width/3)
        colorSwitch.position = CGPoint(x: frame.midX, y: frame.minY + colorSwitch.size.height)
        colorSwitch.zPosition = zpositions.colorSwitch
        colorSwitch.physicsBody = SKPhysicsBody(circleOfRadius: colorSwitch.size.width/2)
        colorSwitch.physicsBody?.categoryBitMask = PhysicsCategories.switchCategory
        colorSwitch.physicsBody?.isDynamic = false
        addChild(colorSwitch)
        scoreLabel.fontName = "AvenirNext-Bold"
        scoreLabel.fontSize = 60.0
        scoreLabel.fontColor = UIColor.white
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        scoreLabel.zPosition = zpositions.label
        addChild(scoreLabel)
        
       spawnBall()
        
    }
    
    func updateScoreLabel() {
        scoreLabel.text = "\(score)"
    }
    
    func spawnBall(){
        currentColorIndex = Int(arc4random_uniform(UInt32(4)))
        
        let ball = SKSpriteNode(texture: SKTexture(imageNamed: "ball"), color: Playcolors.colors[currentColorIndex!], size: CGSize(width: 30.0, height: 30.0))
        ball.colorBlendFactor = 1.0
        ball.name = "Ball"
        ball.position = CGPoint(x: frame.midX, y: frame.maxY)
        ball.zPosition = zpositions.ball
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2)
        ball.physicsBody?.categoryBitMask = PhysicsCategories.ballCategory
        ball.physicsBody?.contactTestBitMask = PhysicsCategories.switchCategory
        ball.physicsBody?.collisionBitMask = PhysicsCategories.none
        addChild(ball)
    }
    
    func turnWheel() {
        if let newState = Switchstate(rawValue: switchstate.rawValue + 1){
         switchstate =  newState
        }else {
            switchstate = .red
        }
        colorSwitch.run(SKAction.rotate(byAngle: .pi/2, duration: 0.20))
        
    }
    
    func gameOver(){
        
        UserDefaults.standard.set(score, forKey: "RecentScore")
        if score > UserDefaults.standard.integer(forKey: "HighScore"){
            UserDefaults.standard.set(score, forKey: "HighScore")
        }
        let menuScene = MenuScore(size: view!.bounds.size)
        view!.presentScene(menuScene)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        turnWheel()
    }
    


    
}

extension GameScene:SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if contactMask == PhysicsCategories.ballCategory | PhysicsCategories.switchCategory{
            if let ball = contact.bodyA.node?.name == "Ball" ? contact.bodyA.node as?SKSpriteNode : contact.bodyB.node as? SKSpriteNode{
                if(currentColorIndex == switchstate.rawValue){
                    impactFeedbackGenerator.light.prepare()
                    impactFeedbackGenerator.medium.prepare()
                    impactFeedbackGenerator.heavy.prepare()
                    
                    run(SKAction.playSoundFileNamed("Ding", waitForCompletion: false))
                    score += 1
                    impactFeedbackGenerator.heavy.impactOccurred()
                    updateScoreLabel()
                    ball.run(SKAction.fadeOut(withDuration: 0.25), completion: {
                        ball.removeFromParent()
                        self.spawnBall()
                        })
                    
                }else{
                    gameOver()
                }
            }
        }
    }
}
