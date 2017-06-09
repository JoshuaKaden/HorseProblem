//
//  ViewController.swift
//  HorseProblem
//
//  Created by Kaden, Joshua on 6/9/17.
//  Copyright © 2017 Kaden, Joshua. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    private let autoButton = TapButton()
    private let goButton = TapButton()
    private let textLabel = UILabel()
    private let titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("The Horse Problem", comment: "")
        
        autoButton.backgroundColor = UIColor.blue
        autoButton.title = NSLocalizedString("Automated", comment: "")
        autoButton.tapAction = {
            [weak self] in
            let vc = AutoViewController()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        view.addSubview(autoButton)
        
        goButton.backgroundColor = UIColor.blue
        goButton.title = NSLocalizedString("Start", comment: "")
        goButton.tapAction = {
            [weak self] in
            let vc = RacesViewController()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        view.addSubview(goButton)
        
        let text = "There are 25 horses. You may race 5 horses at a time, but you do not know the time it took each horse to finish; you only receive rankings (1st, 2nd, 3rd, etc.). In order to find the 3 fastest horses, how many races must you run?"
        textLabel.lineBreakMode = .byWordWrapping
        textLabel.numberOfLines = 0
        textLabel.text = NSLocalizedString(text, comment: "")
        view.addSubview(textLabel)
        
        titleLabel.text = NSLocalizedString("The Horse Problem", comment: "")
        view.addSubview(titleLabel)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        titleLabel.sizeToFit()
        titleLabel.centerHorizontallyInSuperview()
        
        textLabel.size = textLabel.sizeThatFits(CGSize(width: view.width - 48, height: view.height))
        textLabel.centerHorizontallyInSuperview()
        textLabel.y = titleLabel.maxY + 24
        
        goButton.size = CGSize(width: 300, height: 60)
        goButton.centerHorizontallyInSuperview()
        goButton.y = textLabel.maxY + 24

        autoButton.size = CGSize(width: 300, height: 60)
        autoButton.centerHorizontallyInSuperview()
        autoButton.y = goButton.maxY + 24

        view.centerSubviewsVertically([titleLabel, textLabel, goButton, autoButton])
    }
}
