//
//  HomeViewController.swift
//  TwentyOne 2020
//
//  Created by Brandon Niedert on 12/5/20.
//

import UIKit

class HomeViewController: UIViewController {

    var teams: [Team] {
        return getTeams()
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
    
}
