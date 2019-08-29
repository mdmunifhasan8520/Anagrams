//
//  Level.swift
//  Anagrams
//
//  Created by Md Munif Hasan on 29/8/19.
//  Copyright © 2019 TempestCode. All rights reserved.
//

import Foundation

struct Level {
    let pointsPerTile: Int
    let timeToSolve: Int
    let anagrams: [NSArray]
    
    init(levelNumber: Int) {
        //1 find .plist file for this level
        let fileName = "level\(levelNumber).plist"
        let levelPath = "\(Bundle.main.resourcePath!)/\(fileName)"
        
        //2 load .plist file
        let levelDictionary: NSDictionary? = NSDictionary(contentsOfFile: levelPath)
        
        //3 validation
        assert(levelDictionary != nil, "Level configuration file not found")
        
        //4 initialize the object from the dictionary
        self.pointsPerTile = levelDictionary!["pointsPerTile"] as! Int
        self.timeToSolve = levelDictionary!["timeToSolve"] as! Int
        self.anagrams = levelDictionary!["anagrams"] as! [NSArray]
    }
}
