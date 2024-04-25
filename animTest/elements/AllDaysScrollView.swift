import Foundation
import UIKit

class AllDaysScrollView: UIScrollView{
    required init?(coder: NSCoder){
        super.init(coder: coder)
    }
    
    var lastDateType: DateType?
    var viewController = UIViewController()
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func addDates(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        var dates: [String] = []
        for task in TasksData.shared.tasks{
            //если даты еще нет и она не завтра сегодня
            if dates.contains(dateFormatter.string(from: task.taskDate)) == false &&
                dateFormatter.string(from: task.taskDate) != dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: 1, to: Date())!) &&
                dateFormatter.string(from: task.taskDate) != dateFormatter.string(from: Date()){
                
                    dates.append(dateFormatter.string(from: task.taskDate))
            }
        }
        dates.sort()
        dates.map{addDate(date: dateFormatter.date(from: $0)!)}
    }
    
    func clearDates(){
        for view in self.subviews{
            view.removeFromSuperview()
        }
        lastDateType = nil
    }
    
    func addDate(date: Date){
        let dateType = DateType(date: date, superScroll: self)
        if let lastDate = lastDateType{
            dateType.center = CGPoint(x: dateType.center.x,
                                      y: lastDate.center.y + DateType.size.height + 15)
            contentSize = CGSize(width: contentSize.width,
                                 height: contentSize.height + TaskType.size.height + 15)
            lastDateType = dateType
            addSubview(dateType)
        }
        else{
            contentSize = DateType.size
            addSubview(dateType)
            lastDateType = dateType
        }
    }
}
