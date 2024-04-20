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
}
