//
//  AutoViewController.swift
//  HorseProblem
//
//  Created by Kaden, Joshua on 6/9/17.
//  Copyright © 2017 Kaden, Joshua. All rights reserved.
//

import UIKit

final class AutoViewController: UIViewController {
    
    private var shouldCancel: Bool = false
    
    private var failures: Int = 0
    private var successes: Int = 0
    
    private let cancelButton = TapButton()
    private let failureLabel = UILabel()
    private let successLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        title = NSLocalizedString("Automated Races", comment: "")
        
        cancelButton.backgroundColor = UIColor.blue
        cancelButton.title = NSLocalizedString("Cancel", comment: "")
        cancelButton.tapAction = {
            [weak self] in
            self?.shouldCancel = true
        }
        view.addSubview(cancelButton)
        
        failureLabel.text = "0"
        failureLabel.textColor = UIColor.red
        view.addSubview(failureLabel)
        
        successLabel.text = "0"
        successLabel.textColor = UIColor.green
        view.addSubview(successLabel)
        
        let _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(start), userInfo: nil, repeats: true);
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        successLabel.sizeToFit()
        successLabel.centerHorizontallyInSuperview()
        
        failureLabel.sizeToFit()
        failureLabel.centerHorizontallyInSuperview()
        failureLabel.y = successLabel.maxY + 24
        
        cancelButton.size = CGSize(width: 300, height: 60)
        cancelButton.centerHorizontallyInSuperview()
        cancelButton.y = failureLabel.maxY + 24
        
        view.centerSubviewsVertically([successLabel, failureLabel, cancelButton])
    }
    
    @objc private func start() {
        if shouldCancel { return }
        
        let raceRunner = RaceRunner()
        let races = raceRunner.runRaces()
        let horses = raceRunner.horses
        
        if races[0].first == horses[0] && races[6].first == horses[1] && races[6].second == horses[2] {
            successes += 1
        } else {
            failures += 1
        }
        
        successLabel.text = "\(successes)"
        failureLabel.text = "\(failures)"
        
        view.setNeedsLayout()
    }
}
