//
//  Stable.swift
//  HorseProblem
//
//  Created by Kaden, Joshua on 6/9/17.
//  Copyright © 2017 Kaden, Joshua. All rights reserved.
//

import GameplayKit

final class Stable {
    private static var names = [
        "Honeydew",
        "Watermelon",
        "Canteloupe",
        "Kiwi",
        "Apple",
        "Orange",
        "Grape",
        "Strawberry",
        "Cherry",
        "Grapefruit",
        "Mango",
        "Blackberry",
        "Blueberry",
        "Raspberry",
        "Pear",
        "Peach",
        "Nectarine",
        "Plum",
        "Durian",
        "Starfruit",
        "Pomogranate",
        "Yam",
        "Carrot",
        "Beet",
        "Lettuce"
    ]
    
    class func supplyHorses() -> [Horse] {
        let randomizer = GKShuffledDistribution(lowestValue: 10, highestValue: 99)
        return names.map {
            name in
            let speed = randomizer.nextInt()
            return Horse(name: name, speed: speed)
        }
    }
}
