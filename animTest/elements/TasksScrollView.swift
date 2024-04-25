//
//  customUIScrollView.swift
//  animTest
//
//  Created by Данила Бондарь on 22.03.2024.
//

import Foundation
import UIKit

class TasksScrollView: UIScrollView{
    
    private var addTaskButton: UIImageView!
    var lastTask: TaskType? = nil //последняя добавленная таска
    var activeTasks = Array<TaskType>()
    var taskEditAlert: EditAlertView?
    var forDate: Date!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        create()

    }
    
    init (){
        super.init(frame: CGRect(x: 0, y: 0, width: .max, height: .max))
        create()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func create(){

    }
    
    // MARK: - Tasks
    @objc
    func addTaskButtonPressed(_ sender: UITapGestureRecognizer){
        let task = TaskType(superScroll: self, text: "", date: forDate, description: "", isDone: false)
        task.setEditAlert(taskEditAlert!)
        addTask(task)
        task.taskName.becomeFirstResponder()
    }
    
    func addTask(_ taskToAdd: TaskType){
        taskToAdd.setScroll(self)
        if taskToAdd.isDone == false || activeTasks.isEmpty{//ставим неготовый таск наверх или если тасков нет
            for task in activeTasks{
                task.center = CGPoint(x: task.center.x, y: task.center.y + TaskType.size.height + 15)
            }
            activeTasks.insert(taskToAdd, at: 0)
        }
        else{
            
            var isAfterNotDoneTask = false //после неготовых тасок
            
            for (id, task) in activeTasks.enumerated(){
                
                if (task.isDone == true && isAfterNotDoneTask == false){ //если попали на первую готовую таску
                    isAfterNotDoneTask = true
                    taskToAdd.center = task.center
                    activeTasks.insert(taskToAdd, at: id)
                }
                if isAfterNotDoneTask{
                    task.center = CGPoint(x: task.center.x, y: task.center.y + TaskType.size.height + 15)
                }
            }
            if isAfterNotDoneTask == false{ //если нет готовых тасок
                taskToAdd.center = CGPoint(x: activeTasks.last!.center.x,
                                           y: activeTasks.last!.center.y + TaskType.size.height + 15)
                activeTasks.append(taskToAdd)
            }
        }
        
        if TasksData.shared.tasks.contains(taskToAdd) == false {TasksData.shared.tasks.append(taskToAdd)}
        
        if let editAlert = taskEditAlert {taskToAdd.setEditAlert(editAlert)}
        addSubview(taskToAdd)
        
        //анимация появления
        taskToAdd.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.5, animations: {
            taskToAdd.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
    
    
    //MARK: Task Managing
    func deleteTask(_ taskToDelete: TaskType){
        let activeTasksCenters = activeTasks.map {$0.center}
        var isAfterTask = false //чтобы получить все таски после удаляемого
        
        
        for (id, task) in activeTasks.enumerated(){ //перемещаем все неготовые таски после нажатой наверх
            
            if (id == activeTasks.endIndex || task.isDone){break}
            
            if isAfterTask{
                task.animSnapTo(point: activeTasksCenters[id-1])
            }
            if taskToDelete == task{
                isAfterTask = true
            }
        }
        
        //перемещаем текущую таску в начало готовых
        var firstDoneTaskId: Int? {
            get{
                self.activeTasks.firstIndex(where: { $0.isDone })
            }
        }

        if firstDoneTaskId == 0{
            taskToDelete.animSnapTo(point: activeTasksCenters[0])
        }
        else{
            taskToDelete.animSnapTo(point: activeTasksCenters[ (firstDoneTaskId ?? self.activeTasks.endIndex)-1 ])
        }

        
        //перемещаем таски в массиве, текущую в начало готовых
        activeTasks.removeAll(where: {$0 == taskToDelete})
        activeTasks.insert(taskToDelete, at: firstDoneTaskId ?? activeTasks.endIndex)
        taskToDelete.animFade()
        taskToDelete.isDone = true
    }
    func undeleteTask(_ taskToUndelete: TaskType){
        let activeTasksCenters = activeTasks.map { $0.center }
        
        for (id, task) in activeTasks.enumerated(){
            if task == taskToUndelete {break}
            task.animSnapTo(point: activeTasksCenters[id+1])
        }
        
        if taskToUndelete != activeTasks[0] {taskToUndelete.animSnapTo(point: activeTasksCenters[0])}
        
        activeTasks.removeAll(where: {$0 == taskToUndelete})
        activeTasks.insert(taskToUndelete, at: 0)
        taskToUndelete.animUnfade()
        taskToUndelete.isDone = false
    }
    
    func removeTask(_ taskToRemove: TaskType?){
        guard let taskToRemove else {return}
        let activeTasksCenters = activeTasks.map {$0.center}
        var isAfterTask = false //чтобы получить все таски после удаляемого
        
        for (id, task) in activeTasks.enumerated(){
            
            if isAfterTask{
                task.animSnapTo(point: activeTasksCenters[id-1])
            }
            
            if task == taskToRemove{
                isAfterTask = true
                UIView.animate(withDuration: 0.5, animations: {
                    task.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                }, completion: {_ in 
                    task.removeFromSuperview()
                })
            }
        }
        self.contentSize = CGSize(width: self.contentSize.width, height: self.contentSize.height - TaskType.size.height - 15)
        activeTasks.removeAll(where: {$0 == taskToRemove})
    }
    
    func clearLastTask(){
        self.lastTask = nil
    }
    
    func setDate(_ date: Date){
        self.forDate = date
        activeTasks.map {$0.taskDate = date}
    }
    //MARK: setAlerts
    func setEditAlert(_ alert: EditAlertView){
        self.taskEditAlert = alert
        activeTasks.map {$0.setEditAlert(alert)}
    }
    func setAddTaskButton(_ button: UIImageView){
        self.addTaskButton = button
        let tap = UITapGestureRecognizer(target: self, action: #selector(addTaskButtonPressed(_:)))
        self.addTaskButton.addGestureRecognizer(tap)
    }
}
