import Foundation
import UIKit

class EditAlertView: UIView{
    
    private var taskNameField: UITextField!
    private var taskDatePicker: UIDatePicker!
    private var taskDescriptionField: UITextField!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let recogniser = UITapGestureRecognizer(target: self, action: #selector(hide(_:)))
        self.addGestureRecognizer(recogniser)
        
        findFields()
        taskNameField.text = "очко"
    }
    
    func findFields(){
        for view in getAllSubviews(of: self){
            switch view.restorationIdentifier{
            case "taskName": taskNameField = (view as! UITextField)
            case "taskDate": taskDatePicker = (view as! UIDatePicker)
            case "taskDescription": taskDescriptionField = (view as! UITextField)
            default: continue
            }
        }
    }
    
    func setFieldsValue(task: TaskType){
        self.taskNameField.text = task.taskName.text
        self.taskDescriptionField.text = task.taskDescription
        self.taskDatePicker.date = task.taskDate
    }
    
    func getAllSubviews(of view: UIView) -> [UIView]{
        var subviews: [UIView] = []
        for subview in view.subviews{
            subviews += getAllSubviews(of: subview)
        }
        subviews += [view]
        return subviews
    }
    
    @objc
    func hide(_ sender: UITapGestureRecognizer){ self.alpha = 0}
    func show(){self.alpha = 1}
}
