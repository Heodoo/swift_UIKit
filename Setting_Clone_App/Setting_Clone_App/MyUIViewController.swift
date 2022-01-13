//
//  MyUIViewController.swift
//  Setting_Clone_App
//
//  Created by 허두영 on 2022/01/13.
//

import UIKit

class MyUIViewController: UIViewController {
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!{
        didSet{
            //처음상태 비활성화
            nextButton.isEnabled = false
        }
    }
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func doCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //여기서 찾을거니까 self
        //editingChanged 외워두는게 좋음 값이 삭제되거나 추가될떄
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        
        //nextButton didset으로 대체
        //textFieldDidChange(sender: emailTextField)
        
    }

    @objc func textFieldDidChange(sender: UITextField) {
        //print(sender.text ?? "")
        if sender.text?.isEmpty == true {
            //텍스트필드가 비어있을떄는 next버튼 비활성화
            nextButton.isEnabled = false
        }else{
            nextButton.isEnabled = true
        }
    }
}
