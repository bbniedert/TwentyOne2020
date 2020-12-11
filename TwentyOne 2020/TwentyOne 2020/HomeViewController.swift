//
//  HomeViewController.swift
//  TwentyOne 2020
//
//  Created by Brandon Niedert on 12/5/20.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var teamSelectionCollectionView: UICollectionView!
    @IBOutlet weak var leftTeamLabel: UILabel!
    @IBOutlet weak var rightTeamLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    var teams: [Team] {
        return getTeams()
    }

    var leftTeam: Team? {
        didSet {
            leftTeamLabel.text = leftTeam?.name
        }
    }

    var rightTeam: Team? {
        didSet {
            rightTeamLabel.text = rightTeam?.name
            startButton.isHidden = false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        teamSelectionCollectionView.register(UINib(nibName: "TeamSelectionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "teamCell")
    }

    @IBAction func didTapGenerateTournament(_ sender: Any) {
        if let path = Bundle.main.path(forResource: "tournamentsetup", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [String: Any], let teams = jsonResult["teams"] as? [[String: Any]] {
                    var teamList = [Team]()
                    for team in teams {
                        if let teamName = team["teamName"] as? String,
                           let players = team["players"] as? [[String: Any]] {
                            guard let leftPlayerJson = players.filter({ $0["position"] as? String == "left" }).first,
                                  let centerPlayerJson = players.filter({ $0["position"] as? String == "center" }).first,
                                  let rightPlayerJson = players.filter({ $0["position"] as? String == "right" }).first,
                                  let leftPlayer = createPlayerFrom(leftPlayerJson),
                                  let centerPlayer = createPlayerFrom(centerPlayerJson),
                                  let rightPlayer = createPlayerFrom(rightPlayerJson) else { return }
                            let team = Team(name: teamName, leftPlayer: leftPlayer, centerPlayer: centerPlayer, rightPlayer: rightPlayer)
                            teamList.append(team)
                        }
                    }

                    saveTeams(teamList)
                }
            } catch {
                print()
            }
        }
    }

    private func createPlayerFrom(_ json: [String: Any]) -> Player? {
        guard let name = json["playerName"] as? String,
              let shootingStyle = json["shootingStyle"] as? Int,
              let targetStrategy = json["targetStrategy"] as? Int,
              let drinkTime = json["drinkTiming"] as? Double,
              let shootingPercentage = json["shootingPercentage"] as? Double else { return nil }
        return Player(name: name, shootingStyle: ShootingStyle(rawValue: shootingStyle) ?? .normal, targetStrategy: TargetStrategy(rawValue: targetStrategy) ?? .random, drinkTiming: drinkTime, shootingPercentage: shootingPercentage)
    }

    private func saveTeams(_ teams: [Team]) {
        do {
            try UserDefaults.standard.setValue(PropertyListEncoder().encode(teams), forKey: "teams")
        } catch {
            print()
        }
    }

    private func getTeams() -> [Team] {
        if let teamData = UserDefaults.standard.object(forKey: "teams") as? Data {
            do {
                return try PropertyListDecoder().decode([Team].self, from: teamData)
            } catch {
                print()
            }
        }
        return [Team]()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let hudVC = segue.destination as? HudViewController, let leftTeam = leftTeam, let rightTeam = rightTeam {
            hudVC.addTeams(leftTeam: leftTeam, rightTeam: rightTeam)
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let team = teams[indexPath.row]
        if leftTeam == nil || rightTeam != nil {
            leftTeam = team
        } else {
            rightTeam = team
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as? TeamSelectionCollectionViewCell else { return UICollectionViewCell() }

        let team = teams[indexPath.row]
        cell.configure(name: team.name)
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 8.0
        let height = collectionView.frame.height / 2.0
        return CGSize(width: width, height: height)
    }
}
