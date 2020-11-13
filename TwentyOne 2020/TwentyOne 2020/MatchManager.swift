//
//  MatchManager.swift
//  TwentyOne 2020
//
//  Created by Brandon Niedert on 11/13/20.
//

import Foundation

class MatchManager
{
    static let instance = MatchManager()
    var leftCupsAvailable = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21]
    var rightCupsAvailable = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21]

    func removeCup(leftShooter: Bool, target: Int) {
        if leftShooter {
            guard let index = rightCupsAvailable.firstIndex(of: target) else { return }
            rightCupsAvailable.remove(at: index)
            print(rightCupsAvailable)
        } else {
            guard let index = leftCupsAvailable.firstIndex(of: target) else { return }
            leftCupsAvailable.remove(at: index)
            print(leftCupsAvailable)
        }
    }
}
