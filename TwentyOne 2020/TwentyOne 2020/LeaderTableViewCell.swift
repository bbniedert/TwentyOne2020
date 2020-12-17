//
//  LeaderTableViewCell.swift
//  TwentyOne 2020
//
//  Created by Brandon Niedert on 12/16/20.
//

import UIKit

class LeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!

    func configure(name: String, stat: String, rank: Int) {
        rankLabel.text = "#\(rank)"
        playerLabel.text = name
        valueLabel.text = stat
    }
}
