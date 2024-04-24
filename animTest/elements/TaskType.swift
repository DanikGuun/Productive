import Foundation
import UIKit

final class TaskType: UIView, UITextFieldDelegate{
    
    static let size = CGSize(width: 380, height: 46) //размер плашки с заданием
    static let checkBoxSize = 50
    var superScroll: TasksScrollView?
    
    var taskName = UITextField()
    var taskDate = Date()
    var taskDescription = ""
    var isDone = false
    
    var editAlert: EditAlertView!
    var fade = UIView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init(superScroll: TasksScrollView?, text: String, date: Date, description: String, isDone: Bool) {
        super.init(frame: CGRect(x: 0, y: 0, width: TaskType.size.width, height: TaskType.size.height))
        self.superScroll = superScroll
        if let superScroll{
            self.center = CGPoint(x: superScroll.frame.size.width  / 2, y: self.center.y+15)
        }
        self.taskName.text = text
        self.taskDate = date
        self.taskDescription = description
        self.isDone = isDone
        createInfoButton()
        createCheckBox()
        createText(text: text)
        createFade()
        
        if isDone{
            animFade()
            
        }
    }
    override func layoutSubviews(){//Настройка параметров отображения
        self.backgroundColor = superScroll?.backgroundColor
        self.layer.cornerRadius = 9
        self.layer.shadowColor = CGColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.3)
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 2
    }
    
    func updateTask(){
        taskName.text = editAlert.taskNameField.text
        if taskDate != editAlert.taskDatePicker.date{
            superScroll?.removeTask(self)
        }
        taskDate = editAlert.taskDatePicker.date
        taskDescription = editAlert.taskDescriptionField.text ?? ""
    }
    
    private func createText(text: String){
        taskName.text = text
        taskName.textColor = UIColor(cgColor: CGColor(red: 0.24, green: 0.64, blue: 0.81, alpha: 1))
        taskName.font = UIFont(name: "bloggersans-medium", size: 20)
        taskName.frame = CGRect(x: TaskType.checkBoxSize, y: 2, width: Int(TaskType.size.width) - TaskType.checkBoxSize*2, height: 46)
        taskName.returnKeyType = .done
        taskName.delegate = self
        self.addSubview(taskName)
    }
    private func createCheckBox(){
        let button = RadioButton(frame: CGRect(x: 0, y: -1, width: TaskType.checkBoxSize, height: TaskType.checkBoxSize), superTask: self)
        
        self.addSubview(button)
    }
    private func createInfoButton(){
        let button = InformationButton(frame: CGRect(x: Int(TaskType.size.width)-TaskType.checkBoxSize, y: -1, width: TaskType.checkBoxSize, height: TaskType.checkBoxSize), superTask: self)
        
        self.addSubview(button)
    }
    private func createFade(){
        fade.isUserInteractionEnabled = false
        fade.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        fade.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        fade.layer.cornerRadius = 9
        self.addSubview(fade)
    }
    
    //чтобы клавиатура скрывалась
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func animSnapTo(point: CGPoint){
        UIView.animate(withDuration: 0.5, animations: {
            self.center = point
        })
    }
    
    func setEditAlert(_ alert: EditAlertView){
        self.editAlert = alert
    }
    func setScroll(_ scroll: TasksScrollView){
        self.superScroll = scroll
        self.center = CGPoint(x: scroll.frame.size.width  / 2, y: self.center.y+15)
    }
    
    func animFade(){
        UIView.animate(withDuration: 0.5, animations: {
            self.fade.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        })
    }
    func animUnfade(){
        UIView.animate(withDuration: 0.5, animations: {
            self.fade.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
        })
    }

    
    //MARK: INFO BUTTON
    private final class InformationButton: UIButton{
        var superTaskType: TaskType!
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        override init(frame: CGRect){
            super.init(frame: frame)
            preset()
        }
        convenience init(frame: CGRect, superTask: TaskType){
            self.init(frame: frame)
            self.superTaskType = superTask
        }
        
        func preset(){
            self.tintColor = UIColor(cgColor: CGColor(red: 0.67, green: 0.67, blue: 0.67, alpha: 1))
            self.setImage(.information, for: .normal)
            
            let recogniser = UITapGestureRecognizer(target: self, action: #selector(buttonPressed(_:)))
            self.addGestureRecognizer(recogniser)
        }
    
        @objc
        func buttonPressed(_ sender: UITapGestureRecognizer){
            superTaskType.editAlert.setFieldsValue(task: superTaskType)
            superTaskType.editAlert.show()
        }
    }
    
    //MARK: TaskDoneButton
    private final class RadioButton: UIButton{
        var isToggle = false
        var superTask: TaskType!
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            self.superTask = nil
        }
        override init(frame: CGRect){
            super.init(frame: frame)
            preset()
        }
        convenience init(frame: CGRect, superTask: TaskType){
            self.init(frame: frame)
            self.superTask = superTask
            if superTask.isDone{
                isToggle = true
                self.setImage(.radioButtonEnabled, for: .normal)
                self.tintColor = UIColor(red: 0.21, green: 0.49, blue: 0.8, alpha: 1)
            }
        }
        
        func preset(){
            self.tintColor = UIColor(cgColor: CGColor(red: 0.71, green: 0.71, blue: 0.71, alpha: 1))
            self.setImage(.radioButtonDisabled, for: .normal)
            
            let recogniser = UITapGestureRecognizer(target: self, action: #selector(radioButtonPressed(_:)))
            self.addGestureRecognizer(recogniser)
        }
        
        @objc
        private func radioButtonPressed(_ sender: UITapGestureRecognizer){
            print(TasksData.shared.tasks.count)
            func enable(){
                UIButton.animate(withDuration: 0.2, animations: {
                    self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                }
                ,completion: { _ in
                    self.setImage(.radioButtonEnabled, for: .normal)
                    self.tintColor = UIColor(red: 0.21, green: 0.49, blue: 0.8, alpha: 1)
                    UIButton.animate(withDuration: 0.2, animations: {
                        self.transform = CGAffineTransform(scaleX: 1, y: 1)
                    })
                })
                isToggle = true
            }
            func disable(){
                UIButton.animate(withDuration: 0.2, animations: {
                    self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                }
                ,completion: { _ in
                    self.setImage(.radioButtonDisabled, for: .normal)
                    self.tintColor = UIColor(cgColor: CGColor(red: 0.71, green: 0.71, blue: 0.71, alpha: 1))
                    UIButton.animate(withDuration: 0.2, animations: {
                        self.transform = CGAffineTransform(scaleX: 1, y: 1)
                    })
                })
                isToggle = false
            }

            if isToggle { disable() }
            else { enable() }
            asyncTaskCheck()
            
        }
        func asyncTaskCheck(){
            Timer.scheduledTimer(withTimeInterval: 1.2, repeats: false, block: {timer in
                if self.isToggle{ self.superTask.superScroll?.deleteTask(self.superTask) }
                else { self.superTask.superScroll?.undeleteTask(self.superTask) }
            })
        }
    }
}
