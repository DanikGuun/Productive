import UIKit

class CustomAlertView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    
    // Передайте значения для заголовка и сообщения
    func setup(title: String, message: String) {
        titleLabel.text = title
        messageLabel.text = message
    }
    
    // Обработка нажатия на кнопку OK
    @IBAction func okButtonTapped(_ sender: Any) {
        // Закройте кастомный алерт
        removeFromSuperview()
    }
}
