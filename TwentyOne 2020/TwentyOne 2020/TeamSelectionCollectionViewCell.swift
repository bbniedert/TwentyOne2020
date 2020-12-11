//
//  TeamSelectionCollectionViewCell.swift
//  TwentyOne 2020
//
//  Created by Brandon Niedert on 12/11/20.
//

import UIKit

class TeamSelectionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!

    func configure(name: String) {
        nameLabel.text = name
    }
}
