import Foundation
import UIKit

class EditAlertView: UIView{
    
    var taskNameField: UITextField!
    var taskDatePicker: UIDatePicker!
    var taskDescriptionField: UITextField!
    var deleteButton: UIButton!
    
    var viewController: UIViewController!
    
    var editableTask: TaskType?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

        findFields()
        
        let recogniser = UITapGestureRecognizer(target: self, action: #selector(hide(_:)))
        self.addGestureRecognizer(recogniser)
        
        let buttonRecogniser = UITapGestureRecognizer(target: self, action: #selector(requestTaskDelete(_:)))
        deleteButton.addGestureRecognizer(buttonRecogniser)
        
    }
    
    func findFields(){
        for view in getAllSubviews(of: self){
            switch view.restorationIdentifier{
            case "taskName": taskNameField = (view as! UITextField)
            case "taskDate": taskDatePicker = (view as! UIDatePicker)
            case "taskDescription": taskDescriptionField = (view as! UITextField)
            case "delete": deleteButton = (view as! UIButton)
            default: continue
            }
        }

    }
    
    @objc func requestTaskDelete(_ sender: UITapGestureRecognizer){
        print(1)
        let alert = UIAlertController(title: "Вай биля удалять буш?", message: nil, preferredStyle: .actionSheet)
        
        let confirm = UIAlertAction(title: "Да", style: .destructive) {_ in
            self.deleteTask()
            self.hide(nil)
        }
        let disagree = UIAlertAction(title: "Нет", style: .default)
        
        alert.addAction(disagree)
        alert.addAction(confirm)
        
        viewController.present(alert, animated: true)
    }
    
    func deleteTask(){
        editableTask?.superScroll?.removeTask(editableTask)
        TasksData.shared.tasks.removeAll {$0 == editableTask}
    }
    
    func setFieldsValue(task: TaskType){
        self.taskNameField.text = task.taskName.text
        self.taskDescriptionField.text = task.taskDescription != "" ? task.taskDescription : nil
        self.taskDatePicker.date = task.taskDate
        self.editableTask = task
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
    func hide(_ sender: UITapGestureRecognizer?){
        self.alpha = 0
        editableTask?.updateTask()
        self.endEditing(true)
    }
    func show(){self.alpha = 1}
    
    func setViewController(_ viewController: UIViewController){
        self.viewController = viewController
    }
}
