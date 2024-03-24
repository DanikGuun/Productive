//
//  customUIScrollView.swift
//  animTest
//
//  Created by Данила Бондарь on 22.03.2024.
//

import Foundation
import UIKit

class CustomUIScrollView: UIScrollView{
    
    var lastTask: TaskType? = nil
    
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
        addTask(TaskType(superScroll: self))
        for _ in 1...17{
            addTask(TaskType(superScroll: self))
        }
    }
    func addTask(_ task: TaskType){
        if let lastTaskType = lastTask{
            task.center = CGPoint(x: task.center.x, y: lastTaskType.center.y + TaskType.size.height + 10) //ставим размер
            contentSize = CGSize(width: contentSize.width, height: contentSize.height + TaskType.size.height + 10)
            lastTask = task
            addSubview(task)
        }
        else{
            addSubview(task)
            contentSize = task.frame.size
            lastTask = task
        }
    }
}
