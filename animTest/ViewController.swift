//
//  ViewController.swift
//  animTest
//
//  Created by Данила Бондарь on 07.03.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var todayButton: UIImageView!
    @IBOutlet var todayLabel: UILabel!
    @IBOutlet var todayScrollView: UIScrollView!
    @IBOutlet var todayChangeButton: UIView!
    @IBOutlet var allDaysButton: UIImageView!
    @IBOutlet var allDaysLabel: UILabel!
    @IBOutlet var allDaysScrollView: UIScrollView!
 
    var todayMenu: TodayButton = TodayButton()
    var allDaysMenu: MenuElement = MenuElement()
    var menuButtons: Array<MenuElement> = Array()
    
    var currentScrollID = 0 //айдишка, какая кнопка сейчас нажата, чтобы определять, влево или вправо двигать скролл
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todayChangeButton.layer.borderColor = CGColor(red: 0.21, green: 0.49, blue: 0.8, alpha: 1)
        todayChangeButton.layer.borderWidth = 2
        todayChangeButton.layer.cornerRadius = 5
        todayChangeButton.layer.shadowColor = CGColor(red: 0.42, green: 0.42, blue: 0.42, alpha: 1)
        todayChangeButton.layer.shadowOpacity = 0.7
        todayChangeButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        todayChangeButton.layer.shadowRadius = CGFloat(1)
        
        let todayTapRecogniser = UITapGestureRecognizer(target: self, action: #selector(todayButtonPressed(_:)))
        todayButton.addGestureRecognizer(todayTapRecogniser)
        todayButton.isUserInteractionEnabled = true
        let todayChangeTapRecogniser = UITapGestureRecognizer(target: self, action: #selector(todayChangeButtonPressed(_:)))
        todayChangeButton.addGestureRecognizer(todayChangeTapRecogniser)
        todayChangeButton.isUserInteractionEnabled = true
        let allDayTapRecogniser = UITapGestureRecognizer(target: self, action: #selector(allDayButtonPressed(_:)))
        allDaysButton.addGestureRecognizer(allDayTapRecogniser)
        allDaysButton.isUserInteractionEnabled = true
        
        todayMenu = TodayButton(button: todayButton, label: todayLabel, scrollView: todayScrollView, id: 0, isSelected: false, background: todayChangeButton)
        allDaysMenu = MenuElement(button: allDaysButton, label: allDaysLabel, scrollView: allDaysScrollView, id: 1, isSelected: false, labelSize: CGSize(width: 100, height: 30))
        
        menuButtons.append(todayMenu)
        menuButtons.append(allDaysMenu)
        
        menuButtonEnabledAnimate(todayMenu)
    
    }

    @objc
    private func todayButtonPressed(_ sender: UITapGestureRecognizer){
        let tappedImage = sender.view as! UIImageView
        menuButtonEnabledAnimate(getMenuElementByButton(tappedImage))
    }
    
    @objc
    private func todayChangeButtonPressed(_ sender: UIGestureRecognizer){
        var todayButton: TodayButton = getMenuElementByButton(sender.view!)
        let labelHeight = todayButton.label.frame.height //чтобы помнить высоту после обнуления
        
        if todayButton.currentDay == .today{
            UIView.animate(withDuration: 0.5, animations: {
                todayButton.label.center.y += labelHeight
                todayButton.label.frame.size = CGSize(width: todayButton.label.frame.width, height: 0)
            }, completion: { _ in
                todayButton.label.center.y -= labelHeight
                todayButton.label.text = "Завтра"
                UIView.animate(withDuration: 0.5, animations: {
                    todayButton.label.frame.size = CGSize(width: todayButton.label.frame.width, height: labelHeight)
                })
            })
        }
        else{
            UIView.animate(withDuration: 0.5, animations: {
                todayButton.label.frame.size = CGSize(width: todayButton.label.frame.width, height: 0)
            }, completion: { _ in
                todayButton.label.center.y += labelHeight
                todayButton.label.text = "Сегодня"
                UIView.animate(withDuration: 0.5, animations: {
                    todayButton.label.center.y -= labelHeight
                    todayButton.label.frame.size = CGSize(width: todayButton.label.frame.width, height: labelHeight)
                })
            })
        }
        todayButton.currentDay = todayButton.currentDay == CurrentDay.today ? CurrentDay.tommorow : CurrentDay.today//инвертируем
    }
    @objc
    private func allDayButtonPressed(_ sender: UITapGestureRecognizer){
        let tappedImage = sender.view as! UIImageView
        menuButtonEnabledAnimate(getMenuElementByButton(tappedImage))
    }
    
    private func changeScrollView(currentScrollView: UIScrollView, targetScrollView: UIScrollView, currentIndex: Int, targetIndex: Int){
        if currentIndex  < targetIndex{ //окошко влево
            UIScrollView.animate(withDuration: 0.5, animations: {
                currentScrollView.center.x -= currentScrollView.frame.width //поменять на ширину вьюхи
                targetScrollView.center.x = 0
            })
        }
        else{
            UIScrollView.animate(withDuration: 0.5, animations: {
                currentScrollView.center.x += currentScrollView.frame.width //поменять на ширину вьюхи
                targetScrollView.center.x = 0
            })
        }
        currentScrollID = targetIndex
    }
    private func disableMenuButtons(without: UIImageView){
        for element in menuButtons{
            if element.button != without && element.isSelected {menuButtonDisabledAnimate(element)}
        }
    }
    private func menuButtonEnabledAnimate(_ menuElement: MenuElement){
        
        if menuElement.isSelected == true {return}
        
        func anim(_ view: UIView, _ size: CGSize){
            UIView.animate(withDuration: 0.5, animations: {
                menuElement.button.center.x -= 50
                menuElement.button.tintColor = UIColor(red: 0.21, green: 0.49, blue: 0.8, alpha: 1)
                view.frame.size = size
                view.center.x -= 50
            })
        }
        
        if menuElement is TodayButton{ anim((menuElement as! TodayButton).background, (menuElement as! TodayButton).backgeoundSize)}
        else{anim(menuElement.label, menuElement.labelSize) }
        
        menuElement.isSelected = true
        disableMenuButtons(without: menuElement.button)
    }
    private func menuButtonDisabledAnimate(_ menuElement: MenuElement){
        func anim(_ view: UIView, _ size: CGSize){
            
            UIView.animate(withDuration: 0.5, animations: {
                menuElement.button.center.x += 50
                menuElement.button.tintColor = UIColor(red: 0.67, green: 0.67, blue: 0.67, alpha: 1)
                view.frame.size = CGSize(width: 0, height: size.height)
                view.center.x += 50
            })
        }
        
        if menuElement is TodayButton{ anim((menuElement as! TodayButton).background, (menuElement as! TodayButton).backgeoundSize)}
        else{anim(menuElement.label, menuElement.labelSize) }
        
        menuElement.isSelected = false
    }
    func getMenuElementByButton(_ button: UIImageView) -> MenuElement{
        for element in menuButtons{
            if element.button == button {return element}
        }
        print("не найден")
        return MenuElement()
    }
    func getMenuElementByButton(_ button: UIView) -> TodayButton{
        for element in menuButtons{
            if let elem  = element as? TodayButton, elem.background == button {return elem}
        }
        print("Не найден!")
        return TodayButton()
    }
}
    

