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
        self.labelSize = CGSize(width: 0, height: 0)
    }
    
    init(button: UIImageView, label: UILabel, scrollView: UIScrollView, id: Int, isSelected: Bool, labelSize: CGSize? = nil) {
        self.button = button
        self.label = label
        self.scrollView = scrollView
        self.id = id
        self.isSelected = isSelected
        self.labelSize = labelSize ?? label.frame.size //чтобы указать размер, если в SB элемент скрыт
    }
    
    let button: UIImageView
    let label: UILabel
    let scrollView: UIScrollView
    let id: Int
    var isSelected: Bool
    let labelSize: CGSize //чтобы после анимаций возвращать в исходный размер
}

class TodayButton: MenuElement{
    override init(){
        self.currentDay = .today
        self.background = UIView()
        self.backgeoundSize = CGSize(width: 0, height: 0)
        self.tomorrowScrollView = UIScrollView()
        super.init()
    }
    
    init(button: UIImageView, label: UILabel, todayScrollView: UIScrollView, tomorrowScrollView: UIScrollView, id: Int, isSelected: Bool, background: UIView, backgroundSize: CGSize? = nil) {
        self.currentDay = .today
        self.background = background
        self.backgeoundSize = backgroundSize ?? background.frame.size
        self.tomorrowScrollView = tomorrowScrollView
        super.init(button: button, label: label, scrollView: todayScrollView, id: id, isSelected: isSelected)
    }
    
    var currentDay: CurrentDay
    let background: UIView
    let backgeoundSize: CGSize
    let tomorrowScrollView: UIScrollView
}
enum CurrentDay{
    case today
    case tommorow
}
