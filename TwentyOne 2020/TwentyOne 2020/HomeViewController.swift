//
//  HomeViewController.swift
//  TwentyOne 2020
//
//  Created by Brandon Niedert on 12/5/20.
//

import UIKit

protocol HomeDelegate: class {
    func updateTeams()
}

class HomeViewController: UIViewController {

    @IBOutlet weak var standingsTableView: UITableView!
    @IBOutlet weak var cupsDrankTableView: UITableView!
    @IBOutlet weak var shootingTableView: UITableView!
    @IBOutlet weak var clutchCupsTableView: UITableView!
    @IBOutlet weak var teamSelectionCollectionView: UICollectionView!
    
    var teams = [Team]() {
        didSet {
            teamSelectionCollectionView.reloadData()
        }
    }

    var sortedTeams: [Team] {
        return teams.sorted(by: { t1, t2 in
            (t1.wins, t1.cd) > (t2.wins, t2.cd)
        })
    }

    var players: [Player] {
        var list = [Player]()
        for team in teams {
            list.append(team.leftPlayer)
            list.append(team.centerPlayer)
            list.append(team.rightPlayer)
        }
        return list
    }

    var drankPlayers: [Player] {
        return players.sorted(by: { p1, p2 in
            p1.cupsDrank > p2.cupsDrank
        })
    }

    var percentPlayers: [Player] {
        return players.sorted(by: { p1, p2 in
            Double(p1.shotPercent) > Double(p2.shotPercent)
        })
    }

    var clutchPlayers: [Player] {
        return players.sorted(by: { p1, p2 in
            p1.clutchCup > p2.clutchCup
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        teamSelectionCollectionView.register(UINib(nibName: "TeamSelectionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "teamCell")
        standingsTableView.register(UINib(nibName: "StandingTableViewCell", bundle: nil), forCellReuseIdentifier: "standings")
        cupsDrankTableView.register(UINib(nibName: "LeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "drank")
        shootingTableView.register(UINib(nibName: "LeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "shot")
        clutchCupsTableView.register(UINib(nibName: "LeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "clutch")

        getTeams()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        standingsTableView.reloadData()
        cupsDrankTableView.reloadData()
        shootingTableView.reloadData()
        clutchCupsTableView.reloadData()
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
            } catch let error {
                print()
            }
        }
    }

    private func createPlayerFrom(_ json: [String: Any]) -> Player? {
        guard let name = json["playerName"] as? String else { return nil }
        return Player(name: name,
                      shootingStyle: .normal,
                      targetStrategy: .random,
                      shootingPercentage: json["shootingPercentage"] as? Double ?? 30.0,
                      tankStatus: TankStatus(rawValue: json["targetStrategy"] as? Int ?? 0) ?? .none)
    }

    private func saveTeams(_ teams: [Team]) {
        do {
            try UserDefaults.standard.setValue(PropertyListEncoder().encode(teams), forKey: "teams")
            getTeams()
        } catch {
            print()
        }
    }

    private func getTeams(){
        if let teamData = UserDefaults.standard.object(forKey: "teams") as? Data {
            do {
                teams = try PropertyListDecoder().decode([Team].self, from: teamData)
            } catch {
                print()
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let hudVC = segue.destination as? HudViewController {
            hudVC.addTeams(leftTeam: teams.randomElement()!, rightTeam: teams.randomElement()!)
            hudVC.delegate = self
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {

}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teams.count
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

extension HomeViewController: HomeDelegate {
    func updateTeams() {
        saveTeams(teams)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == standingsTableView {
            return teams.count
        } else {
            return 5
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == standingsTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "standings") as? StandingTableViewCell else { return UITableViewCell() }
            cell.configure(team: sortedTeams[indexPath.row], place: indexPath.row + 1)
            return cell
        } else if tableView == cupsDrankTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "drank") as? LeaderTableViewCell else { return UITableViewCell() }
            let player = drankPlayers[indexPath.row]
            cell.configure(name: player.name, stat: "\(player.cupsDrank)", rank: indexPath.row + 1)
            return cell
        } else if tableView == shootingTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "shot") as? LeaderTableViewCell else { return UITableViewCell() }
            let player = percentPlayers[indexPath.row]
            cell.configure(name: player.name, stat: "\(Int(player.shotPercent))%", rank: indexPath.row + 1)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "clutch") as? LeaderTableViewCell else { return UITableViewCell() }
            let player = clutchPlayers[indexPath.row]
            cell.configure(name: player.name, stat: "\(player.clutchCup)", rank: indexPath.row + 1)
            return cell
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / CGFloat(tableView.numberOfRows(inSection: 0))
    }
}
