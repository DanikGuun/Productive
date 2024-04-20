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
    
    var tasks: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasksScrollView.setEditAlert(editAlert)
        tasksScrollView.setAddTaskButton(addTaskButton)
        
        generateTasks(tasks)
    }
    private func generateTasks(_ tasks: [Task]){
        for task in tasks{
            let date = DateFormatter()
            date.dateFormat = "dd.MM.yyyy"
            let taskToAdd = TaskType(superScroll: self.tasksScrollView, text: task.name, date: date.date(from: task.date)!, description: task.description, isDone: task.isDone)
            tasksScrollView.addTask(taskToAdd)
        }
    }
}
