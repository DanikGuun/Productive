//
//  DateScreenViewController.swift
//  animTest
//
//  Created by Данила Бондарь on 16.04.2024.
//

import UIKit

class DateScreenViewController: UIViewController {

    @IBOutlet weak var editAlert: EditAlertView!
    @IBOutlet weak var tasksScrollView: TasksScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasksScrollView.setEditAlert(editAlert)
    }
}
