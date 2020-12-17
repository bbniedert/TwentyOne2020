//
//  MatchViewController.swift
//  TwentyOne 2020
//
//  Created by Brandon Niedert on 11/30/20.
//

import UIKit
import AVFoundation

class MatchViewController: UIViewController {

    @IBOutlet weak var topLeftHome: UIView!
    @IBOutlet weak var centerLeftHome: UIView!
    @IBOutlet weak var bottomLeftHome: UIView!
    @IBOutlet weak var topRightHome: UIView!
    @IBOutlet weak var centerRightHome: UIView!
    @IBOutlet weak var bottomRightHome: UIView!
    @IBOutlet weak var topBall: UIImageView!
    @IBOutlet weak var centerBall: UIImageView!
    @IBOutlet weak var bottomBall: UIImageView!

    

    @IBOutlet weak var leftCup1: UIImageView!
    @IBOutlet weak var leftCup2: UIImageView!
    @IBOutlet weak var leftCup3: UIImageView!
    @IBOutlet weak var leftCup4: UIImageView!
    @IBOutlet weak var leftCup5: UIImageView!
    @IBOutlet weak var leftCup6: UIImageView!
    @IBOutlet weak var leftCup7: UIImageView!
    @IBOutlet weak var leftCup8: UIImageView!
    @IBOutlet weak var leftCup9: UIImageView!
    @IBOutlet weak var leftCup10: UIImageView!
    @IBOutlet weak var leftCup11: UIImageView!
    @IBOutlet weak var leftCup12: UIImageView!
    @IBOutlet weak var leftCup13: UIImageView!
    @IBOutlet weak var leftCup14: UIImageView!
    @IBOutlet weak var leftCup15: UIImageView!
    @IBOutlet weak var leftCup16: UIImageView!
    @IBOutlet weak var leftCup17: UIImageView!
    @IBOutlet weak var leftCup18: UIImageView!
    @IBOutlet weak var leftCup19: UIImageView!
    @IBOutlet weak var leftCup20: UIImageView!
    @IBOutlet weak var leftCup21: UIImageView!

    @IBOutlet weak var rightCup1: UIImageView!
    @IBOutlet weak var rightCup2: UIImageView!
    @IBOutlet weak var rightCup3: UIImageView!
    @IBOutlet weak var rightCup4: UIImageView!
    @IBOutlet weak var rightCup5: UIImageView!
    @IBOutlet weak var rightCup6: UIImageView!
    @IBOutlet weak var rightCup7: UIImageView!
    @IBOutlet weak var rightCup8: UIImageView!
    @IBOutlet weak var rightCup9: UIImageView!
    @IBOutlet weak var rightCup10: UIImageView!
    @IBOutlet weak var rightCup11: UIImageView!
    @IBOutlet weak var rightCup12: UIImageView!
    @IBOutlet weak var rightCup13: UIImageView!
    @IBOutlet weak var rightCup14: UIImageView!
    @IBOutlet weak var rightCup15: UIImageView!
    @IBOutlet weak var rightCup16: UIImageView!
    @IBOutlet weak var rightCup17: UIImageView!
    @IBOutlet weak var rightCup18: UIImageView!
    @IBOutlet weak var rightCup19: UIImageView!
    @IBOutlet weak var rightCup20: UIImageView!
    @IBOutlet weak var rightCup21: UIImageView!

    weak var delegate: MatchDelegate?
    var availableLeftCups = [Int]()
    var availableRightCups = [Int]()
    var makeAudioPlayer: AVAudioPlayer?
    var missAudioPlayer: AVAudioPlayer?
    var miscAudioPlayer: AVAudioPlayer?
    var backgroundAudioPlayer: AVAudioPlayer?

    
    var isPlaying = true {
        didSet {
            if !isPlaying {
                topBall.isHidden = true
                centerBall.isHidden = true
                bottomBall.isHidden = true
                makeAudioPlayer = nil
                missAudioPlayer = nil
                miscAudioPlayer = nil
                backgroundAudioPlayer = nil
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 1...21 {
            availableLeftCups.append(i)
            availableRightCups.append(i)
        }
        if let makeSound = Bundle.main.path(forResource: "AnythingCouldHappen", ofType: "mp3"){
            do{
                backgroundAudioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: makeSound))
                backgroundAudioPlayer?.play()
            }
            catch{
                print(error)
            }
        }
    }
    
    func playSound(sound: String){
        switch sound {
        case "make":
            let number = Int.random(in: 0..<3)
            if number == 0{
                if let makeSound = Bundle.main.path(forResource: "make1", ofType: "wav"){
                    do{
                        makeAudioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: makeSound))
                        makeAudioPlayer?.play()
                    }
                    catch{
                        print(error)
                    }
                }
            }
            if number == 1{
                if let makeSound = Bundle.main.path(forResource: "make2", ofType: "wav"){
                    do{
                        makeAudioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: makeSound))
                        makeAudioPlayer?.play()
                    }
                    catch{
                        print(error)
                    }
                }
            }
            if number == 2{
                if let makeSound = Bundle.main.path(forResource: "make3", ofType: "wav"){
                    do{
                        makeAudioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: makeSound))
                        makeAudioPlayer?.play()
                    }
                    catch{
                        print(error)
                    }
                }
            }

        case "miss":
            if let missSound = Bundle.main.path(forResource: "miss", ofType: "wav"){
                do{
                    missAudioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: missSound))
                    missAudioPlayer?.play()
                }
                catch{
                    print(error)
                }
            }
        case "ballsBack":
            if let ballsBackSound = Bundle.main.path(forResource: "ballsBack", ofType: "wav"){
                do{
                    miscAudioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: ballsBackSound))
                    backgroundAudioPlayer?.pause()
                    miscAudioPlayer?.play()
                    sleep(3)
                    backgroundAudioPlayer?.play()
                }
                catch{
                    print(error)
                }
            }
        case "end":
            if let endSound = Bundle.main.path(forResource: "EndGameJingle1", ofType: "wav"){
                do{
                    miscAudioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: endSound))
                    miscAudioPlayer?.play()
                }
                catch{
                    print(error)
                }
            }
        default:
            print("Didn't work")
        }
        
        
        
    }

    func throwBall(thrower: Player) {
        if (isPlaying) {
            thrower.shotsTaken += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + thrower.getThrowDelay()) {
                let targetCupNumber = thrower.chooseTarget(availableTargets: thrower.isOnLeftSide ? self.availableRightCups : self.availableLeftCups)
                let targetCup = self.getTargetView(cupNumber: targetCupNumber, isLeftShooter: thrower.isOnLeftSide)
                let thrownBall = self.getBallForPosition(thrower.position)
                self.performThrowAnimation(ball: thrownBall, at: targetCup, completion: {
                    self.determineThrowOutcome(thrower: thrower, cupNumber: targetCupNumber) { success in
                        self.prepareBallForNextThrow(throwerPosition: thrower.position)
                        if success {
                            self.makeAudioPlayer?.prepareToPlay()
                            self.playSound(sound: "make")
                            self.delegate?.startDrinkCountdown(player: thrower, completion: {
                                self.delegate?.throwNextBall(previousThrower: thrower)
                            })
                        } else {
                            self.missAudioPlayer?.prepareToPlay()
                            self.playSound(sound: "miss")

                            self.delegate?.throwNextBall(previousThrower: thrower)
                        }
                    }
                })
            }
        }
    }

    func determineThrowOutcome(thrower: Player, cupNumber: Int, completion: @escaping (_ success: Bool) -> Void) {
        if Double.random(in: 0.0..<100.0) < thrower.getShootingPercentage(target: cupNumber) && isPlaying {
            getTargetView(cupNumber: cupNumber, isLeftShooter: thrower.isOnLeftSide).isHidden = true
            var cupAlreadyMade = true
            if thrower.isOnLeftSide {
                let temp = availableRightCups.filter({ $0 != cupNumber })
                if temp.count != availableRightCups.count {
                    availableRightCups = temp
                    delegate?.didMakeRightCup(player: thrower)
                    isPlaying = availableRightCups.count != 0
                    cupAlreadyMade = false
                }
            } else {
                let temp = availableLeftCups.filter({ $0 != cupNumber })
                if temp.count != availableLeftCups.count {
                    availableLeftCups = temp
                    delegate?.didMakeLeftCup(player: thrower)
                    isPlaying = availableLeftCups.count != 0
                    cupAlreadyMade = false
                }
            }
            completion(!cupAlreadyMade)
        } else {
            completion(false)
        }
    }

    private func prepareBallForNextThrow(throwerPosition: TablePosition) {
        switch throwerPosition {
        case .topLeft:
            self.topBall.center = self.topRightHome.center
        case .centerLeft:
            self.centerBall.center = self.centerRightHome.center
        case .bottomLeft:
            self.bottomBall.center = self.bottomRightHome.center
        case .topRight:
            self.topBall.center = self.topLeftHome.center
        case .centerRight:
            self.centerBall.center = self.centerLeftHome.center
        case .bottomRight:
            self.bottomBall.center = self.bottomLeftHome.center
        }
    }

    func gotBallsBack(leftSide: Bool) {
        self.miscAudioPlayer?.prepareToPlay()
        DispatchQueue.global().async {
            self.playSound(sound: "ballsBack")
        }
        if leftSide {
            topBall.center = topLeftHome.center
            centerBall.center = centerLeftHome.center
            bottomBall.center = bottomLeftHome.center
        } else {
            topBall.center = topRightHome.center
            centerBall.center = centerRightHome.center
            bottomBall.center = bottomRightHome.center
        }
    }

    func performThrowAnimation(ball: UIImageView, at cup: UIImageView, completion: @escaping () -> Void) {
        UIView.animate(withDuration: 1.0, animations: {
            ball.center = cup.center
        }, completion: { _ in
            completion()
        })
    }

    private func getTargetView(cupNumber: Int, isLeftShooter: Bool) -> UIImageView {
        switch cupNumber {
        case 1:
            return isLeftShooter ? rightCup1 : leftCup1
        case 2:
            return isLeftShooter ? rightCup2 : leftCup2
        case 3:
            return isLeftShooter ? rightCup3 : leftCup3
        case 4:
            return isLeftShooter ? rightCup4 : leftCup4
        case 5:
            return isLeftShooter ? rightCup5 : leftCup5
        case 6:
            return isLeftShooter ? rightCup6 : leftCup6
        case 7:
            return isLeftShooter ? rightCup7 : leftCup7
        case 8:
            return isLeftShooter ? rightCup8 : leftCup8
        case 9:
            return isLeftShooter ? rightCup9 : leftCup9
        case 10:
            return isLeftShooter ? rightCup10 : leftCup10
        case 11:
            return isLeftShooter ? rightCup11 : leftCup11
        case 12:
            return isLeftShooter ? rightCup12 : leftCup12
        case 13:
            return isLeftShooter ? rightCup13 : leftCup13
        case 14:
            return isLeftShooter ? rightCup14 : leftCup14
        case 15:
            return isLeftShooter ? rightCup15 : leftCup15
        case 16:
            return isLeftShooter ? rightCup16 : leftCup16
        case 17:
            return isLeftShooter ? rightCup17 : leftCup17
        case 18:
            return isLeftShooter ? rightCup18 : leftCup18
        case 19:
            return isLeftShooter ? rightCup19 : leftCup19
        case 20:
            return isLeftShooter ? rightCup20 : leftCup20
        case 21:
            return isLeftShooter ? rightCup21 : leftCup21
        default:
            return leftCup1
        }
    }

    private func getBallForPosition(_ position: TablePosition) -> UIImageView {
        switch position {
        case .topLeft, .topRight:
            return topBall
        case .centerLeft, .centerRight:
            return centerBall
        case .bottomLeft, .bottomRight:
            return bottomBall
        }
    }
}
