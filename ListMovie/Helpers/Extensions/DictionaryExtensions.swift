//
//  DictionaryExtensions.swift
//  HelloPaisaBankingApp
//  Created by Maheep on 06/06/19.
//  Copyright © 2019 Maheep. All rights reserved.
//

import Foundation


// MARK: - Methods
public extension Dictionary {
    
    mutating func updateValues(_ dic: [Key: Value]?) {
        if let dic = dic {
            for (key, value) in dic {
                self[key] = value
            }
        }
    }
    
}
