//
//  RacesViewController.swift
//  HorseProblem
//
//  Created by Kaden, Joshua on 6/9/17.
//  Copyright © 2017 Kaden, Joshua. All rights reserved.
//

import GameplayKit
import UIKit

final class RacesViewController: UIViewController {
    private let horses: [Horse]
    private var raced: [Horse] = []
    fileprivate var races: [Race] = []
    private var unraced: [Horse] = []
    
    private let tableView = UITableView()
    
    init(horses: [Horse] = Stable.supplyHorses().sorted { $0.speed > $1.speed }) {
        self.horses = horses
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("Races", comment: "")
        
        view.backgroundColor = UIColor.white
        
        tableView.dataSource = self
        view.addSubview(tableView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("View Roster", comment: ""), style: .plain, target: self, action: #selector(didTapViewRoster(_:)))
        
        runRaces()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func didTapViewRoster(_ sender: UIBarButtonItem) {
        let vc = RosterViewController(horses: horses)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func runRaces() {
        raced.removeAll(keepingCapacity: false)
        unraced.removeAll(keepingCapacity: false)
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
        
        tableView.reloadData()
    }
    
    private func createRace() -> Race {
        let randomizer = GKRandomDistribution(lowestValue: 0, highestValue: unraced.count - 1)
        
        var nextUp: Set<Horse> = []
        while (nextUp.count < 5) {
            nextUp.insert(unraced[randomizer.nextInt()])
        }
        unraced = unraced.filter { !nextUp.contains($0) }
        raced.append(contentsOf: nextUp)
        
        return createRace(horses: Array(nextUp))
    }
    
    private func createRace(horses: [Horse]) -> Race {
        let raceHorses: [Horse] = horses.sorted { $0.speed > $1.speed }
        return Race(first: raceHorses[0], second: raceHorses[1], third: raceHorses[2], fourth: raceHorses[3], fifth: raceHorses[4])
    }
}

extension RacesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return races.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        
        if indexPath.section == 7 {
            switch indexPath.row {
            case 0:
                let race = races[0]
                cell.textLabel?.text = race.first.name
                cell.detailTextLabel?.text = "\(race.first.speed)"
            case 1:
                let race = races[6]
                cell.textLabel?.text = race.first.name
                cell.detailTextLabel?.text = "\(race.first.speed)"
            case 2:
                let race = races[6]
                cell.textLabel?.text = race.second.name
                cell.detailTextLabel?.text = "\(race.second.speed)"
            default:
                // no op
                break
            }
            return cell
        }
        
        let race = races[indexPath.section]
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = race.first.name
            cell.detailTextLabel?.text = "\(race.first.speed)"
        case 1:
            cell.textLabel?.text = race.second.name
            cell.detailTextLabel?.text = "\(race.second.speed)"
        case 2:
            cell.textLabel?.text = race.third.name
            cell.detailTextLabel?.text = "\(race.third.speed)"
        case 3:
            cell.textLabel?.text = race.fourth.name
            cell.detailTextLabel?.text = "\(race.fourth.speed)"
        case 4:
            cell.textLabel?.text = race.fifth.name
            cell.detailTextLabel?.text = "\(race.fifth.speed)"
        default:
            // no op
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 7 {
            return 3
        }
        return 5
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 7 {
            return "The Three Fastest"
        }
        return "Race #\(section + 1)"
    }
}
