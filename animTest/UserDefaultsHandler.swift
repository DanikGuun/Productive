import Foundation

class UserDefaultsHandler{
    static func SaveData(str: String){
        UserDefaults.standard.set(str, forKey: "data")
    }
    
    static func ReadData() -> String{
        return UserDefaults.standard.string(forKey: "data") ?? ""
    }
}
