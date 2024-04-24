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
    var date: Date!
    
    init(date: Date, superScroll: AllDaysScrollView) {
        super.init(frame: CGRect(x: 0, y: 0, width: DateType.size.width, height: DateType.size.height))
        self.superScroll = superScroll
        self.center = CGPoint(x: superScroll.frame.size.width  / 2, y: self.center.y+15)
        self.date = date

        let tap = UITapGestureRecognizer(target: self, action: #selector(onClick(_:)))
        self.addGestureRecognizer(tap)
        
        createText(date: date)
    }

    @objc
    private func onClick(_ sender: Any?){
        
        var tasksToSend: [TaskType] = []
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        for task in TasksData.shared.tasks{
            if dateFormatter.string(from: task.taskDate) == dateFormatter.string(from: date){
                task.center = CGPoint(x: superScroll.frame.size.width / 2, y: 15)
                tasksToSend.append(task)
            }
        }
        
        superScroll.viewController.performSegue(withIdentifier: "DaySegue", sender: (date, tasksToSend))
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
