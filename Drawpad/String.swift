//
//  String.swift
//  Drawpad
//
//  Created by Loic on 8/1/17.
//  Copyright © 2017 3sparks. All rights reserved.
//

import Foundation

extension String {
    static func random(length: Int = 20) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""
        
        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.characters.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])\(Date().description)"
        }
        return randomString
    }
}
