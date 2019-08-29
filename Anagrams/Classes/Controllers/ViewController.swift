//
//  ViewController.swift
//  Anagrams
//
//  Created by Md Munif Hasan on 29/8/19.
//  Copyright © 2019 TempestCode. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let controller:GameController
    
    required init(coder aDecoder: NSCoder) {
        controller = GameController()
        super.init(coder: aDecoder)!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let level1 = Level(levelNumber: 1)
        //print("anagrams: \(level1.anagrams)")
        
        //add one layer for all game elements
        let gameView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        self.view.addSubview(gameView)
        controller.gameView = gameView
        
        controller.level = level1
        controller.dealRandomAnagram()
    }


}

