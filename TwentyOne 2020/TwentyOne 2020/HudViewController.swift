//
//  HudViewController.swift
//  TwentyOne 2020
//
//  Created by Brandon Niedert on 11/30/20.
//

import UIKit

protocol MatchDelegate: class {
    func didMakeRightCup(drinker: String, completion: () -> Void)
    func didMakeLeftCup(drinker: String, completion: () -> Void)
    func didMakeRightCup()
    func didMakeLeftCup()
}

class HudViewController: UIViewController {

    @IBOutlet weak var leftCupsRemainingLabel: UILabel!
    @IBOutlet weak var rightCupsRemainingLabel: UILabel!

    @IBOutlet weak var topRightDrinkView: UIView!
    @IBOutlet weak var topRightDrinkWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var centerRightDrinkView: UIView!
    @IBOutlet weak var centerRightDrinkWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomRightDrinkView: UIView!
    @IBOutlet weak var bottomRightDrinkWidthConstraint: NSLayoutConstraint!

    @IBOutlet weak var topLeftDrinkView: UIView!
    @IBOutlet weak var topLeftDrinkWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var centerLeftDrinkView: UIView!
    @IBOutlet weak var centerLeftDrinkWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomLeftDrinkView: UIView!
    @IBOutlet weak var bottomLeftDrinkWidthConstraint: NSLayoutConstraint!

    var leftCupsRemaining = 21
    var rightCupsRemaining = 21
    var matchViewController: MatchViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let childController = children.first as? MatchViewController {
            matchViewController = childController
            matchViewController?.delegate = self
        }
    }

    func animateDrinkView(constraint: NSLayoutConstraint?) {
        guard let constraint = constraint else { return }
        constraint.constant = 200
    }
}

extension HudViewController: MatchDelegate {
    func didMakeLeftCup() {
        leftCupsRemaining -= 1
        leftCupsRemainingLabel.text = "\(leftCupsRemaining)"
    }

    func didMakeRightCup() {
        rightCupsRemaining -= 1
        rightCupsRemainingLabel.text = "\(rightCupsRemaining)"
    }

    func didMakeLeftCup(drinker: String, completion: () -> Void) {
        leftCupsRemaining -= 1
        leftCupsRemainingLabel.text = "\(leftCupsRemaining)"
        var constraint: NSLayoutConstraint?
        if drinker == "TOP" {
            constraint = topLeftDrinkWidthConstraint
        } else if drinker == "CENTER" {
            constraint = centerLeftDrinkWidthConstraint
        } else {
            constraint = bottomLeftDrinkWidthConstraint
        }
        animateDrinkView(constraint: constraint)
    }

    func didMakeRightCup(drinker: String, completion: () -> Void) {
        rightCupsRemaining -= 1
        rightCupsRemainingLabel.text = "\(rightCupsRemaining)"
        var constraint: NSLayoutConstraint?
        if drinker == "TOP" {
            constraint = topRightDrinkWidthConstraint
        } else if drinker == "CENTER" {
            constraint = centerRightDrinkWidthConstraint
        } else {
            constraint = bottomRightDrinkWidthConstraint
        }
        animateDrinkView(constraint: constraint)
    }
}
