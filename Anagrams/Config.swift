//
//  Config.swift
//  Anagrams
//
//  Created by Md Munif Hasan on 29/8/19.
//  Copyright © 2019 TempestCode. All rights reserved.
//

import UIKit


//UI Constants
let ScreenWidth = UIScreen.main.bounds.size.width
let ScreenHeight = UIScreen.main.bounds.size.height


let TileMargin: CGFloat = 20.0

//Random number generator
func randomNumber(minX:UInt32, maxX:UInt32) -> Int {
    let result = (arc4random() % (maxX - minX + 1)) + minX
    return Int(result)
}
