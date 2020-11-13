//
//  RackView.swift
//  TwentyOne 2020
//
//  Created by Brandon Niedert on 11/13/20.
//

import UIKit

@IBDesignable
class RackView: UIView {
    @IBOutlet weak var cup1: UIImageView!
    @IBOutlet weak var cup2: UIImageView!
    @IBOutlet weak var cup3: UIImageView!
    @IBOutlet weak var cup4: UIImageView!
    @IBOutlet weak var cup5: UIImageView!
    @IBOutlet weak var cup6: UIImageView!
    @IBOutlet weak var cup7: UIImageView!
    @IBOutlet weak var cup8: UIImageView!
    @IBOutlet weak var cup9: UIImageView!
    @IBOutlet weak var cup10: UIImageView!
    @IBOutlet weak var cup11: UIImageView!
    @IBOutlet weak var cup12: UIImageView!
    @IBOutlet weak var cup13: UIImageView!
    @IBOutlet weak var cup14: UIImageView!
    @IBOutlet weak var cup15: UIImageView!
    @IBOutlet weak var cup16: UIImageView!
    @IBOutlet weak var cup17: UIImageView!
    @IBOutlet weak var cup18: UIImageView!
    @IBOutlet weak var cup19: UIImageView!
    @IBOutlet weak var cup20: UIImageView!
    @IBOutlet weak var cup21: UIImageView!

//    var allCups: [UIImageView] {
//        return [cup1, cup2, cup3, cup4, cup5, cup6, cup7, cup8, cup9, cup10, cup11, cup12, cup13, cup14, cup15, cup16, cup17, cup18, cup19, cup20, cup21]
//    }
//
//    var madeCups = [UIImageView]()

    var view: UIView!
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }

    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        view.autoresizingMask = [
            UIView.AutoresizingMask.flexibleWidth,
            UIView.AutoresizingMask.flexibleHeight
        ]
        addSubview(view)
        self.view = view
    }

    func getCupCenter(cupNumber: Int) -> CGPoint {
        switch cupNumber {
        case 1:
            return convert(CGPoint(x: cup1.center.x, y: cup1.center.y + 60), to: superview?.superview)
        case 2:
            return convert(CGPoint(x: cup2.center.x, y: cup2.center.y + 60), to: superview?.superview)
        case 3:
            return convert(CGPoint(x: cup3.center.x, y: cup3.center.y + 60), to: superview?.superview)
        case 4:
            return convert(CGPoint(x: cup4.center.x, y: cup4.center.y + 60), to: superview?.superview)
        case 5:
            return convert(CGPoint(x: cup5.center.x, y: cup5.center.y + 60), to: superview?.superview)
        case 6:
            return convert(CGPoint(x: cup6.center.x, y: cup6.center.y + 60), to: superview?.superview)
        case 7:
            return convert(CGPoint(x: cup7.center.x, y: cup7.center.y + 60), to: superview?.superview)
        case 8:
            return convert(CGPoint(x: cup8.center.x, y: cup8.center.y + 60), to: superview?.superview)
        case 9:
            return convert(CGPoint(x: cup9.center.x, y: cup9.center.y + 60), to: superview?.superview)
        case 10:
            return convert(CGPoint(x: cup10.center.x, y: cup10.center.y + 60), to: superview?.superview)
        case 11:
            return convert(CGPoint(x: cup11.center.x, y: cup11.center.y + 60), to: superview?.superview)
        case 12:
            return convert(CGPoint(x: cup12.center.x, y: cup12.center.y + 60), to: superview?.superview)
        case 13:
            return convert(CGPoint(x: cup13.center.x, y: cup13.center.y + 60), to: superview?.superview)
        case 14:
            return convert(CGPoint(x: cup14.center.x, y: cup14.center.y + 60), to: superview?.superview)
        case 15:
            return convert(CGPoint(x: cup15.center.x, y: cup15.center.y + 60), to: superview?.superview)
        case 16:
            return convert(CGPoint(x: cup16.center.x, y: cup16.center.y + 60), to: superview?.superview)
        case 17:
            return convert(CGPoint(x: cup17.center.x, y: cup17.center.y + 60), to: superview?.superview)
        case 18:
            return convert(CGPoint(x: cup18.center.x, y: cup18.center.y + 60), to: superview?.superview)
        case 19:
            return convert(CGPoint(x: cup19.center.x, y: cup19.center.y + 60), to: superview?.superview)
        case 20:
            return convert(CGPoint(x: cup20.center.x, y: cup20.center.y + 60), to: superview?.superview)
        case 21:
            return convert(CGPoint(x: cup21.center.x, y: cup21.center.y + 60), to: superview?.superview)
        default:
            return CGPoint(x: 0, y: 0)
        }
    }

    func cupMade(cupNumber: Int) {
        switch cupNumber {
        case 1:
            cup1.isHidden = true
        case 2:
            cup2.isHidden = true
        case 3:
            cup3.isHidden = true
        case 4:
            cup4.isHidden = true
        case 5:
            cup5.isHidden = true
        case 6:
            cup6.isHidden = true
        case 7:
            cup7.isHidden = true
        case 8:
            cup8.isHidden = true
        case 9:
            cup9.isHidden = true
        case 10:
            cup10.isHidden = true
        case 11:
            cup11.isHidden = true
        case 12:
            cup12.isHidden = true
        case 13:
            cup13.isHidden = true
        case 14:
            cup14.isHidden = true
        case 15:
            cup15.isHidden = true
        case 16:
            cup16.isHidden = true
        case 17:
            cup17.isHidden = true
        case 18:
            cup18.isHidden = true
        case 19:
            cup19.isHidden = true
        case 20:
            cup20.isHidden = true
        case 21:
            cup21.isHidden = true
        default:
            return
        }
    }

}
