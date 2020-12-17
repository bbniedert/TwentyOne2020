//
//  StandingTableViewCell.swift
//  TwentyOne 2020
//
//  Created by Brandon Niedert on 12/16/20.
//

import UIKit

class StandingTableViewCell: UITableViewCell {
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var cdLabel: UILabel!

    func configure(team: Team, place: Int) {
        rankLabel.text = "#\(place)"
        teamLabel.text = team.name
        recordLabel.text = "\(team.wins) - \(team.losses)"
        cdLabel.text = "\(team.cd)"
    }
}
