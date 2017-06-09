//
//  RaceRunner.swift
//  HorseProblem
//
//  Created by Kaden, Joshua on 6/9/17.
//  Copyright © 2017 Kaden, Joshua. All rights reserved.
//

import Foundation
import GameplayKit

final class RaceRunner {
    private(set) var horses: [Horse] = []
    private(set) var races: [Race] = []
    private var unraced: [Horse] = []

    func runRaces(horses: [Horse] = Stable.supplyHorses().sorted { $0.speed > $1.speed }) -> [Race] {
        self.horses = horses
        
        races.removeAll()
        unraced.removeAll()
        horses.forEach { self.unraced.append($0) }
        
        // The first 5 races. Each horse gets to run in a race.
        let firstFiveUnsorted = (1...5).map { _ in createRace() }
        
        // The 6th race is the winners of the first 5 races against each other.
        let sixthRaceHorses = [firstFiveUnsorted[0].first, firstFiveUnsorted[1].first, firstFiveUnsorted[2].first, firstFiveUnsorted[3].first, firstFiveUnsorted[4].first]
        let sixthRace = createRace(horses: sixthRaceHorses)
        
        // Note that we'll sort the first 5 races by the winning order of race #6.
        races.append(firstFiveUnsorted.filter({ $0.horses.contains(sixthRace.first) }).first!)
        races.append(firstFiveUnsorted.filter({ $0.horses.contains(sixthRace.second) }).first!)
        races.append(firstFiveUnsorted.filter({ $0.horses.contains(sixthRace.third) }).first!)
        races.append(firstFiveUnsorted.filter({ $0.horses.contains(sixthRace.fourth) }).first!)
        races.append(firstFiveUnsorted.filter({ $0.horses.contains(sixthRace.fifth) }).first!)
        
        races.append(sixthRace)
        
        // The 7th race is second- and third-place from race #6, against second- and third-place from race #1, against second-place from race #2.
        let seventhRaceHorses = [races[5].second, races[5].third, races[0].second, races[0].third, races[1].second]
        races.append(createRace(horses: seventhRaceHorses))
        
        return races
    }
    
    private func createRace() -> Race {
        let randomizer = GKRandomDistribution(lowestValue: 0, highestValue: unraced.count - 1)
        
        var nextUp: Set<Horse> = []
        while (nextUp.count < 5) {
            nextUp.insert(unraced[randomizer.nextInt()])
        }
        unraced = unraced.filter { !nextUp.contains($0) }
        
        return createRace(horses: Array(nextUp))
    }
    
    private func createRace(horses: [Horse]) -> Race {
        let raceHorses: [Horse] = horses.sorted { $0.speed > $1.speed }
        return Race(first: raceHorses[0], second: raceHorses[1], third: raceHorses[2], fourth: raceHorses[3], fifth: raceHorses[4])
    }
}
