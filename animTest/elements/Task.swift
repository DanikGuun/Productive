import Foundation

struct Task: Decodable, Encodable{
    var name: String
    var date: String
    var description: String
    var isDone: Bool
}
