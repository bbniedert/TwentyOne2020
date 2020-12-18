//
//  MatchCollectionViewCell.swift
//  TwentyOne 2020
//
//  Created by Brandon Niedert on 12/18/20.
//

import UIKit

class MatchCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var team1Label: UILabel!
    @IBOutlet weak var team2Label: UILabel!
    @IBOutlet weak var cupLabel: UILabel!
    @IBOutlet weak var borderView: UIView!

    func configure(_ match: Match) {
        borderView.layer.borderWidth = 1.0
        borderView.layer.borderColor = UIColor.white.cgColor
        team1Label.text = match.leftTeam.name
        team1Label.textColor = match.winner == Winner.right ? .gray : .white
        team2Label.text = match.rightTeam.name
        team2Label.textColor = match.winner == Winner.left ? .gray : .white
        cupLabel.text = match.cupDifferential == 0 ? "vs" : "\(match.cupDifferential) cups"
    }
}
