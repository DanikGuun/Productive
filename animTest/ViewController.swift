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
    @IBOutlet var allDaysButton: UIImageView!
    @IBOutlet var allDaysLabel: UILabel!
    @IBOutlet var allDaysScrollView: UIScrollView!
 
    var todayMenu: TodayButton = TodayButton()
    var allDaysMenu: MenuElement = MenuElement()
    var menuButtons: Array<MenuElement> = Array()
    
    var currentScrollID = 0 //айдишка, какая кнопка сейчас нажата, чтобы определять, влево или вправо двигать скролл
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let todayTapRecogniser = UITapGestureRecognizer(target: self, action: #selector(todayButtonPressed(_:)))
        todayButton.addGestureRecognizer(todayTapRecogniser)
        todayButton.isUserInteractionEnabled = true
        let allDayTapRecogniser = UITapGestureRecognizer(target: self, action: #selector(allDayButtonPressed(_:)))
        allDaysButton.addGestureRecognizer(allDayTapRecogniser)
        allDaysButton.isUserInteractionEnabled = true
        
        todayMenu = TodayButton(button: todayButton, label: todayLabel, scrollView: todayScrollView, id: 0, isSelected: false)
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
        UIImageView.animate(withDuration: 0.5, animations: {
            menuElement.button.center.x -= 50
            menuElement.button.tintColor = UIColor(red: 0.21, green: 0.49, blue: 0.8, alpha: 1)
            menuElement.label.frame.size = CGSize(width: 90, height: 30)
            menuElement.label.center.x -= 50
        })
        menuElement.isSelected = true
        disableMenuButtons(without: menuElement.button)
    }
    private func menuButtonDisabledAnimate(_ menuElement: MenuElement){
        UIImageView.animate(withDuration: 0.5, animations: {
            menuElement.button.center.x += 50
            menuElement.button.tintColor = UIColor(red: 0.67, green: 0.67, blue: 0.67, alpha: 1)
            menuElement.label.frame.size = CGSize(width: 0, height: 30)
            menuElement.label.center.x += 50
        })
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
    

