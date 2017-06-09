//
//  Horse.swift
//  HorseProblem
//
//  Created by Kaden, Joshua on 6/9/17.
//  Copyright © 2017 Kaden, Joshua. All rights reserved.
//

import Foundation

func ==(lhs: Horse, rhs: Horse) -> Bool {
    return lhs.name == rhs.name
}

struct Horse: Hashable {
    let name: String
    let speed: Int
    
    var hashValue: Int { return name.hashValue }
}
