//
//  TasksData.swift
//  animTest
//
//  Created by Данила Бондарь on 20.04.2024.
//

import Foundation
class TasksData{
    static let shared = TasksData()
    
    private init(){}
    
    var tasks: [TaskType] = []
}
