import Foundation
import UIKit

class DateType: UIView{
    static let size = CGSize(width: 380, height: 46)
    
    required init?(coder: NSCoder){
        super.init(coder: coder)
    }
    
    var tasks: [TaskType] = []
    var superScroll: AllDaysScrollView!
    var dateText = UILabel()
    let date = Date()
    
    init(date: Date, superScroll: AllDaysScrollView) {
        super.init(frame: CGRect(x: 0, y: 0, width: DateType.size.width, height: DateType.size.height))
        self.superScroll = superScroll
        self.center = CGPoint(x: superScroll.frame.size.width  / 2, y: self.center.y+15)

        let tap = UITapGestureRecognizer(target: self, action: #selector(onClick(_:)))
        self.addGestureRecognizer(tap)
        
        createText(date: date)
    }

    @objc
    private func onClick(_ sender: Any?){
        
        let task1 = Task(name: "Уроки", date: date, description: "мм деньги", isDone: false)
        let task2 = Task(name: "дз", date: date, description: "заколкбало дз", isDone: false)
        let task3 = Task(name: "Vfnfy", date: date, description: "ура жопа", isDone: true)
        
        superScroll.viewController.performSegue(withIdentifier: "DaySegue", sender: [task1, task2, task3])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = superScroll?.backgroundColor
        self.layer.cornerRadius = 9
        self.layer.shadowColor = CGColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.3)
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 2
    }
    
    private func createText(date: Date){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        dateText.text = formatter.string(from: date)
        dateText.textColor = UIColor(cgColor: CGColor(red: 0.24, green: 0.64, blue: 0.81, alpha: 1))
        dateText.font = UIFont(name: "bloggersans-medium", size: 20)
        dateText.frame = CGRect(x: 15, y: 2, width: Int(DateType.size.width), height: Int(DateType.size.height))
        dateText.isUserInteractionEnabled = false
        self.addSubview(dateText)
    }
    
}
