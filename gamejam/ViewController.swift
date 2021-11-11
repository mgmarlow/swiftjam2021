//
//  ViewController.swift
//  gamejam
//
//  Created by Graham Marlow on 11/8/21.
//

import Cocoa
import SpriteKit
import GameplayKit

class ViewController: NSViewController {

    @IBOutlet var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = self.skView {
            // Width and height at 8 * 64
            let scene = GameScene(size: CGSize(width: 512, height: 512))
            scene.scaleMode = .aspectFit
            
            // Present the scene
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
}

