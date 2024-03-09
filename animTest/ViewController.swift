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
    @IBOutlet var todayBackground: UIView!
    @IBOutlet var allDaysButton: UIImageView!
    @IBOutlet var allDaysLabel: UILabel!
    @IBOutlet var allDaysScrollView: UIScrollView!
 
    var todayMenu: TodayButton = TodayButton()
    var allDaysMenu: MenuElement = MenuElement()
    var menuButtons: Array<MenuElement> = Array()
    
    var currentScrollID = 0 //айдишка, какая кнопка сейчас нажата, чтобы определять, влево или вправо двигать скролл
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todayBackground.layer.borderColor = CGColor(red: 0.21, green: 0.49, blue: 0.8, alpha: 1)
        todayBackground.layer.borderWidth = 2
        todayBackground.layer.cornerRadius = 5
        todayBackground.layer.shadowColor = CGColor(red: 0.42, green: 0.42, blue: 0.42, alpha: 1)
        todayBackground.layer.shadowOpacity = 0.7
        todayBackground.layer.shadowOffset = CGSize(width: 0, height: 0)
        todayBackground.layer.shadowRadius = CGFloat(1)
        
        let todayTapRecogniser = UITapGestureRecognizer(target: self, action: #selector(todayButtonPressed(_:)))
        todayButton.addGestureRecognizer(todayTapRecogniser)
        todayButton.isUserInteractionEnabled = true
        let allDayTapRecogniser = UITapGestureRecognizer(target: self, action: #selector(allDayButtonPressed(_:)))
        allDaysButton.addGestureRecognizer(allDayTapRecogniser)
        allDaysButton.isUserInteractionEnabled = true
        
        todayMenu = TodayButton(button: todayButton, label: todayLabel, scrollView: todayScrollView, id: 0, isSelected: false, background: todayBackground)
        allDaysMenu = MenuElement(button: allDaysButton, label: allDaysLabel, scrollView: allDaysScrollView, id: 1, isSelected: false)
        
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
    private func allDayButtonPressed(_ sender: UITapGestureRecognizer){
        let tappedImage = sender.view as! UIImageView
        menuButtonEnabledAnimate(getMenuElementByButton(tappedImage))
    }
    
    private func changeScrollView(currentScrollView: UIScrollView, targetScrollView: UIScrollView, currentIndex: Int, targetIndex: Int){
        if currentIndex  < targetIndex{ //окошко влево
            UIScrollView.animate(withDuration: 0.5, animations: {
                currentScrollView.center.x -= 400 //поменять на ширину вьюхи
                targetScrollView.center.x = 0
            })
        }
        else{
            UIScrollView.animate(withDuration: 0.5, animations: {
                currentScrollView.center.x += 400 //поменять на ширину вьюхи
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
        func anim(_ view: UIView){
            UIView.animate(withDuration: 0.5, animations: {
                menuElement.button.center.x -= 50
                menuElement.button.tintColor = UIColor(red: 0.21, green: 0.49, blue: 0.8, alpha: 1)
                view.frame.size = CGSize(width: 100, height: 30)
                view.center.x -= 50
            })
        }
        
        if menuElement is TodayButton{ anim((menuElement as! TodayButton).background)}
        else{anim(menuElement.label) }
        
        menuElement.isSelected = true
        disableMenuButtons(without: menuElement.button)
    }
    private func menuButtonDisabledAnimate(_ menuElement: MenuElement){
        func anim(_ view: UIView){
            UIView.animate(withDuration: 0.5, animations: {
                menuElement.button.center.x += 50
                menuElement.button.tintColor = UIColor(red: 0.67, green: 0.67, blue: 0.67, alpha: 1)
                view.frame.size = CGSize(width: 0, height: 30)
                view.center.x += 50
            })
        }
        
        if menuElement is TodayButton{ anim((menuElement as! TodayButton).background)}
        else{anim(menuElement.label) }
        
        menuElement.isSelected = false
    }
    func getMenuElementByButton(_ button: UIImageView) -> MenuElement{
        for element in menuButtons{
            if element.button == button {return element}
        }
        print("не найден")
        return MenuElement()
    }
    
}
    

