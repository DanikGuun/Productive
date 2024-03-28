//
//  customUIScrollView.swift
//  animTest
//
//  Created by Данила Бондарь on 22.03.2024.
//

import Foundation
import UIKit

class CustomUIScrollView: UIScrollView{
    
    var lastTask: TaskType? = nil //последняя добавленная таска
    var activeTasks = Array<TaskType>()
    
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
    
    func create(){
        for label in ["убраться на столе", "разобрать посудомойку", "принять ванну", "поучиться рисовать", "вытереть пыль в комнате родителейkjbkdfpikbdfip", "почитать книгу"]{
            addTask(TaskType(superScroll: self, text: label))
        }
    }
    
    // MARK: - Tasks
    func addTask(_ task: TaskType){
        if let lastTaskType = lastTask{
            task.center = CGPoint(x: task.center.x, y: lastTaskType.center.y + TaskType.size.height + 15)
            contentSize = CGSize(width: contentSize.width, height: contentSize.height + TaskType.size.height + 15)//считаем размер скрола
            lastTask = task
            addSubview(task)
        }
        else{
            addSubview(task)
            contentSize = task.frame.size
            lastTask = task
        }
        activeTasks.append(task)
    }
    
    func deleteTask(_ taskToDelete: TaskType){
        
        func anim(task: TaskType, point: CGPoint){
            UIView.animate(withDuration: 0.5, animations: {
                task.center = point
            })
        }
        
        let activeTasksCenters = activeTasks.map {$0.center}
        var isAfterTask = false //чтобы получить все таски после удаляемого
        for (id, task) in activeTasks.enumerated(){
            
            if id == activeTasks.endIndex-1{break}
            
            if taskToDelete == task{
                isAfterTask = true
            }
            if isAfterTask{
                anim(task: activeTasks[id+1], point: activeTasksCenters[id])
            }
        }
        activeTasks.removeAll(where: {$0 == taskToDelete})
        taskToDelete.removeFromSuperview()
        self.contentSize = CGSize(width: contentSize.width, height: contentSize.height - TaskType.size.height - 15)
    }
}
