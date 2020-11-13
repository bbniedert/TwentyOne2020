//
//  ViewController.swift
//  TwentyOne 2020
//
//  Created by Brandon Niedert on 11/13/20.
//

import UIKit

protocol PairDelegate: class {
    func ballWasThrown(success: Bool)
}

class ViewController: UIViewController {

    @IBOutlet weak var leftLeftLabel: UILabel!
    @IBOutlet weak var leftCenterLabel: UILabel!
    @IBOutlet weak var leftRightLabel: UILabel!
    @IBOutlet weak var rightRightLabel: UILabel!
    @IBOutlet weak var rightCenterLabel: UILabel!
    @IBOutlet weak var rightLeftLabel: UILabel!

    var currentMatch: Match?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func startMatch(_ sender: UIButton) {
        sender.isHidden = true

        let leftLeftPlayer = Player()
        let leftCenterPlayer = Player()
        let leftRightPlayer = Player()
        let rightRightPlayer = Player()
        let rightCenterPlayer = Player()
        let rightLeftPlayer = Player()

        let pairOne = Pair(leftPlayer: leftLeftPlayer,
                           rightPlayer: rightRightPlayer,
                           ballState: .leftPlayer,
                           leftLabel: leftLeftLabel,
                           rightLabel: rightRightLabel,
                           delegate: self)

        let pairTwo = Pair(leftPlayer: leftCenterPlayer,
                           rightPlayer: rightCenterPlayer,
                           ballState: .rightPlayer,
                           leftLabel: leftCenterLabel,
                           rightLabel: rightCenterLabel,
                           delegate: self)

        let pairThree = Pair(leftPlayer: leftRightPlayer,
                             rightPlayer: rightLeftPlayer,
                             ballState: .leftPlayer,
                             leftLabel: leftRightLabel,
                             rightLabel: rightLeftLabel,
                             delegate: self)

        currentMatch = Match(leftPair: pairOne, centerPair: pairTwo, rightPair: pairThree)

        leftLeftLabel.text = "HAS BALL"
        leftCenterLabel.text = "WAITING"
        leftRightLabel.text = "HAS BALL"
        rightRightLabel.text = "WAITING"
        rightCenterLabel.text = "HAS BALL"
        rightLeftLabel.text = "WAITING"

        leftLeftLabel.isHidden = false
        leftCenterLabel.isHidden = false
        leftRightLabel.isHidden = false
        rightRightLabel.isHidden = false
        rightCenterLabel.isHidden = false
        rightLeftLabel.isHidden = false

        pairOne.start()
        pairTwo.start()
        pairThree.start()
    }
}

extension ViewController: PairDelegate {
    func ballWasThrown(success: Bool) {
        print()
    }
}

