//
//  TaskType.swift
//  animTest
//
//  Created by Данила Бондарь on 22.03.2024.
//

import Foundation
import UIKit

class TaskType: UIView{
    
    var superScroll: CustomUIScrollView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    init(superScroll: CustomUIScrollView) {
        super.init(frame: CGRect(x: 0, y: 0, width: 380, height: 46))
        self.superScroll = superScroll
    }

    override func layoutSubviews(){
        self.center = CGPoint(x: (superScroll?.frame.size.width ?? 400) / 2, y: self.center.y+10)
        self.backgroundColor = superScroll?.backgroundColor
        self.layer.cornerRadius = 9
        self.layer.shadowColor = CGColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 0.2)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 2
    }
}
