//
//  GameController.swift
//  Anagrams
//
//  Created by Md Munif Hasan on 29/8/19.
//  Copyright © 2019 TempestCode. All rights reserved.
//

import UIKit

class GameController {
    var gameView: UIView!
    var level: Level!
    
    private var tiles = [TileView]()
    private var targets = [TargetView]()
    
    init() {
    }
    
    func placeTile(tileView: TileView, targetView: TargetView) {
        //1
        targetView.isMatched = true
        tileView.isMatched = true
        
        //2
        tileView.isUserInteractionEnabled = false
        
        //3
        UIView.animate(withDuration: 0.35,
                                   delay:0.00,
                                   options:UIView.AnimationOptions.curveEaseOut,
                                   //4
            animations: {
                tileView.center = targetView.center
                tileView.transform = .identity
        },
            //5
            completion: {
                (value:Bool) in
                targetView.isHidden = true
        })
    }
    
    func dealRandomAnagram() {
        //1
        assert(level.anagrams.count > 0, "no level loaded")
        
        //2
        let randomIndex = randomNumber(minX:0, maxX:UInt32(level.anagrams.count-1))
        let anagramPair = level.anagrams[randomIndex]
        
        //3
        let anagram1 = anagramPair[0] as! String
        let anagram2 = anagramPair[1] as! String
        
        //4
        let anagram1length = anagram1.count
        let anagram2length = anagram2.count
        //5
        print("phrase1[\(anagram1length)]: \(anagram1)")
        print("phrase2[\(anagram2length)]: \(anagram2)")
        
        //calculate the tile size
        let tileSide = ceil(ScreenWidth * 0.9 / CGFloat(max(anagram1length, anagram2length))) - TileMargin
        
        //get the left margin for first tile
        var xOffset = (ScreenWidth - CGFloat(max(anagram1length, anagram2length)) * (tileSide + TileMargin)) / 2.0
        
        //adjust for tile center (instead of the tile's origin)
        xOffset += tileSide / 2.0
        
        //initialize target list
        targets = []
        
        //create targets
        for (index, letter) in anagram2.enumerated() {
            if letter != " " {
                let target = TargetView(letter: letter, sideLength: tileSide)
                //target.center = CGPointMake(xOffset + CGFloat(index)*(tileSide + TileMargin), ScreenHeight/4)
                target.center = CGPoint(x: xOffset + CGFloat(index)*(tileSide + TileMargin), y: ScreenHeight/4)
                
                gameView.addSubview(target)
                targets.append(target)
            }
        }
        
        //1 initialize tile list
        tiles = []
        
        //2 create tiles
        for (index, letter) in anagram1.enumerated() {
            //3
            if letter != " " {
                let tile = TileView(letter: letter, sideLength: tileSide)
                //tile.center = CGPointMake(xOffset + CGFloat(index)*(tileSide + TileMargin), ScreenHeight/4*3)
                tile.center = CGPoint(x: xOffset + CGFloat(index)*(tileSide + TileMargin), y: ScreenHeight/4*3)
                
                //tile.randomize()
                tile.dragDelegate = self
                //4
                gameView.addSubview(tile)
                tiles.append(tile)
            }
        }
        
        
    }
}


extension GameController:TileDragDelegateProtocol {
    //a tile was dragged, check if matches a target
    func tileView(tileView: TileView, didDragToPoint point: CGPoint) {
        var targetView: TargetView?
        for tv in targets {
            if tv.frame.contains(point) && !tv.isMatched {
                targetView = tv
                break
            }
        }
        //1 check if target was found
        if let targetView = targetView {
            
            //2 check if letter matches
            if targetView.letter == tileView.letter {
                
                //3
                print("Success! You should place the tile here!")
                self.placeTile(tileView: tileView, targetView: targetView)
                //more stuff to do on success here
                
                print("Check if the player has completed the phrase")
            } else {
                
                //4
                print("Failure. Let the player know this tile doesn't belong here")
                
                //1
                tileView.randomize()
                
                //2
                UIView.animate(withDuration: 0.35,
                                           delay:0.00,
                                           options:UIView.AnimationOptions.curveEaseOut,
                                           animations: {
                                           tileView.center = CGPoint(x: tileView.center.x + CGFloat(randomNumber(minX:0, maxX:40)-20), y: tileView.center.y + CGFloat(randomNumber(minX:20, maxX:30)))
                },
                                           completion: nil)
                
                //more stuff to do on failure here
            }
        }
    }
    
}
