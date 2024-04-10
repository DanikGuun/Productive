import Foundation
import UIKit

class EditAlertView: UIView{
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        getAllSubviews(of: self).map {print($0.restorationIdentifier)}
        
        let recogniser = UITapGestureRecognizer(target: self, action: #selector(hide(_:)))
        self.addGestureRecognizer(recogniser)
    }
    
    func getAllSubviews(of view: UIView) -> [UIView]{
        var subviews: [UIView] = []
        for subview in view.subviews{
            subviews += getAllSubviews(of: subview)
        }
        subviews += [view]
        return subviews
    }
    
    @objc
    func hide(_ sender: UITapGestureRecognizer){
        self.alpha = 0
    }
}
