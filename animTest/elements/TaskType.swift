import Foundation
import UIKit

class TaskType: UIView{
    
    static let size = CGSize(width: 380, height: 46) //размер плашки с заданием
    private var superScroll: CustomUIScrollView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    init(superScroll: CustomUIScrollView) {
        super.init(frame: CGRect(x: 0, y: 0, width: TaskType.size.width, height: TaskType.size.height))
        self.superScroll = superScroll
        self.center = CGPoint(x: superScroll.frame.size.width  / 2, y: self.center.y+15)
        createCheckBox()
    }

    override func layoutSubviews(){//Настройка параметров отображения
        self.backgroundColor = superScroll?.backgroundColor
        self.layer.cornerRadius = 9
        self.layer.shadowColor = CGColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.3)
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 2
    }
    func createCheckBox(){
        let button = RadioButton(frame: CGRect(x: 0, y: -1, width: 50, height: 50), superTask: self)

        self.addSubview(button)
    }

    
    class RadioButton: UIButton{
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
            preset()
        }
        
        func preset(){
            self.tintColor = UIColor(cgColor: CGColor(red: 0.71, green: 0.71, blue: 0.71, alpha: 1))
            self.setImage(.radioButtonDisabled, for: .normal)
            
            let recogniser = UITapGestureRecognizer(target: self, action: #selector(radioButtonPressed(_:)))
            self.addGestureRecognizer(recogniser)
        }
        
        @objc
        private func radioButtonPressed(_ sender: UITapGestureRecognizer){
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
                    self.superTask.superScroll?.deleteTask(self.superTask)
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

            if isToggle {disable()}
            else {enable()}
            
        }
    }
}
