//
//  DateScreenViewController.swift
//  animTest
//
//  Created by Данила Бондарь on 16.04.2024.
//

import UIKit

class DateScreenViewController: UIViewController {

    @IBOutlet weak var editAlert: EditAlertView!
    @IBOutlet weak var addTaskButton: UIImageView!
    @IBOutlet weak var tasksScrollView: TasksScrollView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var tasks: [Task] = []
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
    private func generateTasks(_ tasks: [Task]){
        for task in tasks{
            let taskToAdd = TaskType(superScroll: self.tasksScrollView, text: task.name, date: task.date, description: task.description, isDone: task.isDone)
            tasksScrollView.addTask(taskToAdd)
        }
    }
}
