//
//  Race.swift
//  HorseProblem
//
//  Created by Kaden, Joshua on 6/9/17.
//  Copyright © 2017 Kaden, Joshua. All rights reserved.
//

import Foundation

struct Race {
    let first: Horse
    let second: Horse
    let third: Horse
    let fourth: Horse
    let fifth: Horse
    
    var horses: [Horse] {
        return [first, second, third, fourth, fifth]
    }
}
