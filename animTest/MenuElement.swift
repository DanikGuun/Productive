//
//  MenuElement.swift
//  animTest
//
//  Created by Данила Бондарь on 08.03.2024.
//

import Foundation
import UIKit

class MenuElement{
    init(){
        self.button = UIImageView()
        self.label = UILabel()
        self.scrollView = UIScrollView()
        self.id = -1
        self.isSelected = false
    }
    
    init(button: UIImageView, label: UILabel, scrollView: UIScrollView, id: Int, isSelected: Bool) {
        self.button = button
        self.label = label
        self.scrollView = scrollView
        self.id = id
        self.isSelected = isSelected
    }
    
    let button: UIImageView
    let label: UILabel
    let scrollView: UIScrollView
    let id: Int
    var isSelected: Bool
}

class TodayButton: MenuElement{
    override init(){super.init()}
    
    override init(button: UIImageView, label: UILabel, scrollView: UIScrollView, id: Int, isSelected: Bool) {
        super.init(button: button, label: label, scrollView: scrollView, id: id, isSelected: isSelected)
    }
    
    let background
}
