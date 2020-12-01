//
//  ViewController.swift
//  animations
//
//  Created by Brandon Niedert on 11/19/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var redView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func animate(_ sender: Any) {
        UIView.animate(withDuration: 3.0, animations: {
            self.greenView.center = CGPoint(x: 300, y: 800)
        })

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            UIView.animate(withDuration: 3.0, animations: {
                self.redView.center = CGPoint(x: 100, y: 0)
            })
        }
    }

}

