//
//  DateScreenViewController.swift
//  animTest
//
//  Created by Данила Бондарь on 16.04.2024.
//

import UIKit

class DateScreenViewController: UIViewController {

    @IBOutlet weak var addTaskButton: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var editAlert: EditAlertView!
    @IBOutlet weak var tasksScrollView: TasksScrollView!
    
    var tasks: [TaskType] = []
    var forDay = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasksScrollView.setEditAlert(editAlert)
        tasksScrollView.setAddTaskButton(addTaskButton)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateLabel.text = dateFormatter.string(from: forDay)
        
        tasksScrollView.setDate(forDay)
        
        generateTasks(tasks)
    }
     
    private func generateTasks(_ tasks: [TaskType]){
        for task in tasks{
            task.setScroll(tasksScrollView)
            tasksScrollView.addTask(task)
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        tasksScrollView.clearLastTask()
    }
}
