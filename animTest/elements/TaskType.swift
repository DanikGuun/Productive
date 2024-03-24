//
//  TaskType.swift
//  animTest
//
//  Created by Данила Бондарь on 22.03.2024.
//

import Foundation
import UIKit

class TaskType: UIView{
    
    private var superScroll: CustomUIScrollView?
    static let size = CGSize(width: 380, height: 46)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    init(superScroll: CustomUIScrollView) {
        super.init(frame: CGRect(x: 0, y: 0, width: TaskType.size.width, height: TaskType.size.height))
        self.superScroll = superScroll
    }

    override func layoutSubviews(){
        self.center = CGPoint(x: (superScroll?.frame.size.width ?? 400) / 2, y: self.center.y+10)
        self.backgroundColor = superScroll?.backgroundColor
        self.layer.cornerRadius = 9
        self.layer.shadowColor = CGColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.3)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 2
    }
}
