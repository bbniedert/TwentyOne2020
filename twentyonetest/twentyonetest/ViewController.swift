//
//  ViewController.swift
//  twentyonetest
//
//  Created by Brandon Niedert on 11/30/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var topLeftHome: UIView!
    @IBOutlet weak var centerLeftHome: UIView!
    @IBOutlet weak var bottomLeftHome: UIView!
    @IBOutlet weak var topRightHome: UIView!
    @IBOutlet weak var centerRightHome: UIView!
    @IBOutlet weak var bottomRightHome: UIView!
    @IBOutlet weak var topBall: UIView!
    @IBOutlet weak var centerBall: UIView!
    @IBOutlet weak var bottomBall: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapStart(_ sender: Any) {
        ballOne()
        ballTwo()
        ballThree()
    }

    func ballOne() {
        let number = Int.random(in: 0..<3)
        DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(number)) {
            UIView.animate(withDuration: 2.0, animations: {
                self.topBall.center = self.topRightHome.center
            }, completion: { _ in
                let number = Int.random(in: 0..<3)
                DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(number)) {
                    UIView.animate(withDuration: 2.0, animations: {
                        self.topBall.center = self.topLeftHome.center
                    }, completion: { _ in
                        self.ballOne()
                    })
                }
            })
        }
    }

    func ballTwo() {
        let number = Int.random(in: 0..<3)
        DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(number)) {
            UIView.animate(withDuration: 2.0, animations: {
                self.centerBall.center = self.centerRightHome.center
            }, completion: { _ in
                let number = Int.random(in: 0..<3)
                DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(number)) {
                    UIView.animate(withDuration: 2.0, animations: {
                        self.centerBall.center = self.centerLeftHome.center
                    }, completion: { _ in
                        self.ballTwo()
                    })
                }
            })
        }
    }

    func ballThree() {
        let number = Int.random(in: 0..<3)
        DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(number)) {
            UIView.animate(withDuration: 2.0, animations: {
                self.bottomBall.center = self.bottomRightHome.center
            }, completion: { _ in
                let number = Int.random(in: 0..<3)
                DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(number)) {
                    UIView.animate(withDuration: 2.0, animations: {
                        self.bottomBall.center = self.bottomLeftHome.center
                    }, completion: { _ in
                        self.ballThree()
                    })
                }
            })
        }
    }

}

