//
//  HudViewController.swift
//  TwentyOne 2020
//
//  Created by Brandon Niedert on 11/30/20.
//

import UIKit

protocol MatchDelegate: class {
    func didMakeRightCup(player: Player)
    func didMakeLeftCup(player: Player)
    func throwNextBall(previousThrower: Player)
    func startDrinkCountdown(player: Player,  completion: @escaping () -> Void)
}

class HudViewController: UIViewController {

    weak var delegate: HomeDelegate?

    @IBOutlet weak var leftCupsRemainingLabel: UILabel!
    @IBOutlet weak var rightCupsRemainingLabel: UILabel!
    @IBOutlet weak var ballsBackLabel: UILabel!
    
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
    @IBOutlet weak var endMatchButton: UIButton!

    @IBOutlet weak var player1Name: UILabel!
    @IBOutlet weak var player2Name: UILabel!
    @IBOutlet weak var player3Name: UILabel!
    @IBOutlet weak var player4Name: UILabel!
    @IBOutlet weak var player5Name: UILabel!
    @IBOutlet weak var player6Name: UILabel!
    @IBOutlet weak var topLeftScoreLabel: UILabel!
    @IBOutlet weak var centerLeftScoreLabel: UILabel!
    @IBOutlet weak var bottomLeftScoreLabel: UILabel!
    @IBOutlet weak var topRightScoreLabel: UILabel!
    @IBOutlet weak var centerRightScoreLabel: UILabel!
    @IBOutlet weak var bottomRightScoreLabel: UILabel!
    @IBOutlet weak var topLeftTournamentLabel: UILabel!
    @IBOutlet weak var centerLeftTournamentLabel: UILabel!
    @IBOutlet weak var bottomLeftTournamentLabel: UILabel!
    @IBOutlet weak var topRightTournamentLabel: UILabel!
    @IBOutlet weak var centerRightTournamentLabel: UILabel!
    @IBOutlet weak var bottomRightTournamentLabel: UILabel!
    
    var leftCupsRemaining = 21
    var rightCupsRemaining = 21
    var matchViewController: MatchViewController?

    var match: Match?
    var leftTeam: Team?
    var rightTeam: Team?
    var player1: Player?
    var player2: Player?
    var player3: Player?
    var player4: Player?
    var player5: Player?
    var player6: Player?

    var currentDrinkers = [Player]()

    override func viewDidLoad() {
        super.viewDidLoad()
        if let childController = children.first as? MatchViewController {
            matchViewController = childController
            matchViewController?.delegate = self
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        player1Name.text = player1?.name
        player2Name.text = player2?.name
        player3Name.text = player3?.name
        player4Name.text = player4?.name
        player5Name.text = player5?.name
        player6Name.text = player6?.name

        player1?.currentGameCupsMade = 0
        player2?.currentGameCupsMade = 0
        player3?.currentGameCupsMade = 0
        player4?.currentGameCupsMade = 0
        player5?.currentGameCupsMade = 0
        player6?.currentGameCupsMade = 0

        updateScoreLabels(for: player1)
        updateScoreLabels(for: player2)
        updateScoreLabels(for: player3)
        updateScoreLabels(for: player4)
        updateScoreLabels(for: player5)
        updateScoreLabels(for: player6)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.ballsBackLabel.isHidden = false
            self.ballsBackLabel.text = "3"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                self.ballsBackLabel.isHidden = false
                self.ballsBackLabel.text = "2"
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                    self.ballsBackLabel.isHidden = false
                    self.ballsBackLabel.text = "1"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                        self.ballsBackLabel.isHidden = false
                        self.ballsBackLabel.text = "21!!!"
                        self.startMatch()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                            self.ballsBackLabel.text = "Balls Back!"
                            self.ballsBackLabel.isHidden = true
                        })
                    })
                })
            })
        })
    }

    func addMatch(_ match: Match, leftTeam: Team, rightTeam: Team) {
        self.match = match

        self.leftTeam = leftTeam
        self.rightTeam = rightTeam

        player1 = leftTeam.leftPlayer
        player1?.position = .topLeft
        player1?.rollForHotStreak()

        player2 = leftTeam.centerPlayer
        player2?.position = .centerLeft
        player2?.rollForHotStreak()

        player3 = leftTeam.rightPlayer
        player3?.position = .bottomLeft
        player3?.rollForHotStreak()

        player4 = rightTeam.rightPlayer
        player4?.position = .topRight
        player4?.rollForHotStreak()

        player5 = rightTeam.centerPlayer
        player5?.position = .centerRight
        player5?.rollForHotStreak()

        player6 = rightTeam.leftPlayer
        player6?.position = .bottomRight
        player6?.rollForHotStreak()
    }

    private func ballsBack() {
        DispatchQueue.main.async() {
            self.ballsBackLabel.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                self.ballsBackLabel.isHidden = true
            })
        }
    }

    private func rightWins() {
        endMatchButton.isHidden = leftCupsRemaining > 0
        ballsBackLabel.text = "\(rightTeam?.name ?? "") wins!"
        ballsBackLabel.isHidden = false
        rightTeam?.splitCups(cups: rightCupsRemaining)
        leftTeam?.losses += 1
        leftTeam?.cd -= rightCupsRemaining
        rightTeam?.wins += 1
        rightTeam?.cd += rightCupsRemaining
        match?.winner = .right
        match?.cupDifferential = rightCupsRemaining
        matchViewController?.playSound(sound: "end")
        delegate?.updateTeams()
        goBack()
    }

    private func leftWins() {
        endMatchButton.isHidden = false
        ballsBackLabel.text = "\(leftTeam?.name ?? "") wins!"
        ballsBackLabel.isHidden = false
        leftTeam?.splitCups(cups: leftCupsRemaining)
        rightTeam?.losses += 1
        rightTeam?.cd -= leftCupsRemaining
        leftTeam?.wins += 1
        leftTeam?.cd += leftCupsRemaining
        match?.winner = .left
        match?.cupDifferential = leftCupsRemaining
        matchViewController?.playSound(sound: "end")
        delegate?.updateTeams()
        goBack()
    }

    private func goBack() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 8.0, execute: {
            self.navigationController?.popViewController(animated: false)
        })
    }
    
    func startMatch() {
        if let player1 = player1, let player5 = player5, let player3 = player3, let _ = player2, let _ = player4, let _ = player6, let match = matchViewController {
            match.throwBall(thrower: player1)
            match.throwBall(thrower: player5)
            match.throwBall(thrower: player3)
        }
    }

    private func checkForBallsBack() -> Bool {
        if currentDrinkers.count == 3 {
            if currentDrinkers.contains(where: { $0.position == .topLeft }) &&
                currentDrinkers.contains(where: { $0.position == .centerLeft }) &&
                currentDrinkers.contains(where: { $0.position == .bottomLeft }) {
                ballsBack()
                return true
            } else if currentDrinkers.contains(where: { $0.position == .topRight }) &&
                        currentDrinkers.contains(where: { $0.position == .centerRight }) &&
                        currentDrinkers.contains(where: { $0.position == .bottomRight }) {
                ballsBack()
                return true
            }
        }
        return false
    }

    @IBAction func didTapEndMatch(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }

    private func updateScoreLabels(for player: Player?) {
        guard let player = player else { return }
        var gameLabel: UILabel?
        var tournamentLabel: UILabel?
        switch player.position {
        case .topLeft:
            gameLabel = topLeftScoreLabel
            tournamentLabel = topLeftTournamentLabel
        case .centerLeft:
            gameLabel = centerLeftScoreLabel
            tournamentLabel = centerLeftTournamentLabel
        case .bottomLeft:
            gameLabel = bottomLeftScoreLabel
            tournamentLabel = bottomLeftTournamentLabel
        case .topRight:
            gameLabel = topRightScoreLabel
            tournamentLabel = topRightTournamentLabel
        case .centerRight:
            gameLabel = centerRightScoreLabel
            tournamentLabel = centerRightTournamentLabel
        case .bottomRight:
            gameLabel = bottomRightScoreLabel
            tournamentLabel = bottomRightTournamentLabel
        }
        gameLabel?.text = "\(player.currentGameCupsMade)"
        tournamentLabel?.text = "Drank: \(player.cupsDrank) Shot Percent: \(Int(player.shotPercent))%"
    }

    private func getDrinkTiming(throwerPosition: TablePosition) -> Double {
        switch throwerPosition {
        case .topLeft:
            return player4?.drinkTiming ?? 1.5
        case .centerLeft:
            return player5?.drinkTiming ?? 1.5
        case .bottomLeft:
            return player6?.drinkTiming ?? 1.5
        case .topRight:
            return player1?.drinkTiming ?? 1.5
        case .centerRight:
            return player2?.drinkTiming ?? 1.5
        case .bottomRight:
            return player4?.drinkTiming ?? 1.5
        }

    }
}

extension HudViewController: MatchDelegate {
    func didMakeLeftCup(player: Player) {
        leftCupsRemaining -= 1
        if leftCupsRemaining == 0 {
            player.clutchCup += 1
            rightWins()
        }
        leftCupsRemainingLabel.text = "\(leftCupsRemaining)"
    }

    func didMakeRightCup(player: Player) {
        rightCupsRemaining -= 1
        if rightCupsRemaining == 0 {
            player.clutchCup += 1
            leftWins()
        }
        rightCupsRemainingLabel.text = "\(rightCupsRemaining)"
    }

    func throwNextBall(previousThrower: Player) {
        updateScoreLabels(for: previousThrower)
        var nextThrower: Player?
        switch previousThrower.position {
        case .topLeft:
            nextThrower = player4
        case .centerLeft:
            nextThrower = player5
        case .bottomLeft:
            nextThrower = player6
        case .topRight:
            nextThrower = player1
        case .centerRight:
            nextThrower = player2
        case .bottomRight:
            nextThrower = player3
        }

        guard let match = matchViewController, let thrower = nextThrower else { return }
        if previousThrower.hasBallBack {
            previousThrower.hasBallBack = false
            match.throwBall(thrower: previousThrower)
        } else {
            match.throwBall(thrower: thrower)
        }
    }

    func startDrinkCountdown(player: Player, completion: @escaping () -> Void) {
        player.madeCups += 1
        player.currentGameCupsMade += 1
        updateScoreLabels(for: player)
        var constraintToChange: NSLayoutConstraint?
        var drinkView: UIView?
        var currentDrinker: Player?
        switch player.position {
        case .topLeft:
            currentDrinker = player4
            constraintToChange = topRightDrinkWidthConstraint
            drinkView = topRightDrinkView
        case .centerLeft:
            currentDrinker = player5
            constraintToChange = centerRightDrinkWidthConstraint
            drinkView = centerRightDrinkView
        case .bottomLeft:
            currentDrinker = player6
            constraintToChange = bottomRightDrinkWidthConstraint
            drinkView = bottomRightDrinkView
        case .topRight:
            currentDrinker = player1
            constraintToChange = topLeftDrinkWidthConstraint
            drinkView = topLeftDrinkView
        case .centerRight:
            currentDrinker = player2
            constraintToChange = centerLeftDrinkWidthConstraint
            drinkView = centerLeftDrinkView
        case .bottomRight:
            currentDrinker = player3
            constraintToChange = bottomLeftDrinkWidthConstraint
            drinkView = bottomLeftDrinkView
        }

        if let constraint = constraintToChange, let drinkView = drinkView, let currentDrinker = currentDrinker {
            currentDrinker.cupsDrank += 1
            updateScoreLabels(for: currentDrinker)
            currentDrinkers.append(currentDrinker)

            if checkForBallsBack() {
                matchViewController?.gotBallsBack(leftSide: player.isOnLeftSide)
                if player.isOnLeftSide {
                    player1?.hasBallBack = true
                    player2?.hasBallBack = true
                    player3?.hasBallBack = true
                } else {
                    player4?.hasBallBack = true
                    player5?.hasBallBack = true
                    player6?.hasBallBack = true
                }
                self.currentDrinkers.removeAll()
            }

            drinkView.isHidden = false
            constraint.constant = 0
            UIView.animate(withDuration: getDrinkTiming(throwerPosition: player.position), animations: {
                self.view.layoutSubviews()
            }, completion: { _ in
                constraint.constant = 200
                drinkView.isHidden = true
                self.currentDrinkers = self.currentDrinkers.filter({ $0.position != currentDrinker.position })
                completion()
            })
        }
    }
}
