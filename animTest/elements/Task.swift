import Foundation

struct Task: Decodable, Encodable{
    var name: String
    var date: Date
    var description: String
    var isDone: Bool
}
