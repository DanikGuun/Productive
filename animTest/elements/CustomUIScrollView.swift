//
//  customUIScrollView.swift
//  animTest
//
//  Created by Данила Бондарь on 22.03.2024.
//

import Foundation
import UIKit

class CustomUIScrollView: UIScrollView{
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init (){
        super.init(frame: CGRect(x: 0, y: 0, width: .max, height: .max))
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(TaskType(superScroll: self))
        addSubview(TaskType(superScroll: self))
        addSubview(TaskType(superScroll: self))
        
    }
}
