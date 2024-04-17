//
//  customUIScrollView.swift
//  animTest
//
//  Created by Данила Бондарь on 22.03.2024.
//

import Foundation
import UIKit

class TasksScrollView: UIScrollView{
    
    private var lastTask: TaskType? = nil //последняя добавленная таска
    var activeTasks = Array<TaskType>()
    var taskEditAlert: EditAlertView!
    
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
        for label in ["убраться на столе", "разобрать посудомойку", "принять ванну", "поучиться рисовать", "вытереть пыль в комнате родителей", "почитать книгу"]{
            addTask(TaskType(superScroll: self, text: label, date: Date(), description: "", isDone: false))
        }
    }
    
    // MARK: - Tasks
    func addTask(_ task: TaskType){
        if let lastTaskType = lastTask{
            task.center = CGPoint(x: task.center.x, y: lastTaskType.center.y + TaskType.size.height + 15)
            self.contentSize = CGSize(width: contentSize.width, height: contentSize.height + TaskType.size.height + 15)//считаем размер скрола
            lastTask = task
            addSubview(task)
        }
        else{
            addSubview(task)
            self.contentSize = task.frame.size
            lastTask = task
        }
        activeTasks.append(task)
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

        taskToDelete.animSnapTo(point: activeTasksCenters[ (firstDoneTaskId ?? self.activeTasks.endIndex)-1 ])

        
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
    
    func removeTask(_ taskToRemove: TaskType){
        let activeTasksCenters = activeTasks.map {$0.center}
        var isAfterTask = false //чтобы получить все таски после удаляемого
        
        for (id, task) in activeTasks.enumerated(){
            
            if isAfterTask{
                task.animSnapTo(point: activeTasksCenters[id-1])
            }
            
            if task == taskToRemove{
                isAfterTask = true
                UIView.animate(withDuration: 1, animations: {
                    task.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                }, completion: {_ in 
                    task.removeFromSuperview()
                })
            }
        }
        self.contentSize = CGSize(width: self.contentSize.width, height: self.contentSize.height - TaskType.size.height - 15)
        activeTasks.removeAll(where: {$0 == taskToRemove})
    }
    
    //MARK: setAlerts
    func setEditAlert(_ alert: EditAlertView){
        self.taskEditAlert = alert
        activeTasks.map {$0.setEditAlert(alert)}
        
    }
}
