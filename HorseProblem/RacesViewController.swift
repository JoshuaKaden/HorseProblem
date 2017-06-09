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
    private let raceRunner = RaceRunner()
    fileprivate var races: [Race] = []
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
        races = raceRunner.runRaces(horses: horses)
        tableView.reloadData()
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
