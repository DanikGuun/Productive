import Foundation
import UIKit

class AllDaysScrollView: UIScrollView{
    required init?(coder: NSCoder){
        super.init(coder: coder)
        addDate(date: Date())
        for i in 1...10{
            let date_ = Date()
            addDate(date: Calendar.current.date(byAdding: .day, value: i, to: date_)!)
        }
    }
    
    var lastDateType: DateType?
    var viewController = UIViewController()
    
    override func layoutSubviews() {
        super.layoutSubviews()
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
