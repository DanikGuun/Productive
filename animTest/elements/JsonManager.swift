import Foundation

class JsonManager{
    static func TaskToString(_ tasks: [Task]) -> String{
        do{
            let encode = try JSONEncoder().encode(tasks)
            let str = String(data: encode, encoding: .utf8)
            return str!
        }
        catch {print(error)}
        return ""
    }
    static func TaskToString(_ taskTypes: [TaskType]) -> String{
        var tasks: [Task] = []
        for task in taskTypes{
            tasks.append(Task(name: task.taskName.text ?? "", date: task.taskDate, description: task.taskDescription, isDone: task.isDone))
        }
        return TaskToString(tasks)
    }
}
