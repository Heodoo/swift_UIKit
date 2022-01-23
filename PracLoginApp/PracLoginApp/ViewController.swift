//
//  ViewController.swift
//  PracLoginApp
//
//  Created by 허두영 on 2022/01/22.
//

import UIKit

class ViewController: UIViewController {
    var email:String?
    var pw:String?
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var pwTextField: UITextField!
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //emailTextField.delegate = self
        //pwTextField.delegate = self
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        pwTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        loginButton.isEnabled = false
        loginButton.backgroundColor = .gray
        loginButton.addTarget(self, action: #selector(touchloginButton), for: .touchUpInside)
        
    }
    @objc func textFieldDidChange() {
        if let hasEmail = emailTextField.text, let hasPw = pwTextField.text {
            if hasEmail.count > 5 && hasPw.count > 5{
                loginButton.isEnabled = true
                loginButton.backgroundColor = .systemBlue
                
            }
        }
    }
    
    @objc func touchloginButton () {
        let welcomeVC = WelcomeViewController()
        welcomeVC.modalPresentationStyle = .fullScreen
        self.present(welcomeVC, animated: true, completion: nil)
    }
    
    


}
/*
extension ViewController : UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
        if let hasEmail = emailTextField.text, let haspw = pwTextField.text {
            if hasEmail.count > 5 && haspw.count > 5{
                loginButton.isEnabled = true
                loginButton.backgroundColor = .blue
            }
            
        }
        return true
    }
    
}
*/
