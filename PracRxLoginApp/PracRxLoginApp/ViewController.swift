//
//  ViewController.swift
//  PracRxLoginApp
//
//  Created by 허두영 on 2022/01/23.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    //just 나 from은 처음부터 생성해야할 객체를 이미 만들고나서 순차적으로 데이터를 내보지만
    //subject는 통로만 만들어넣고 외부에서 값을 넣을 수 있음, 그래서 나중에도 값을 더 추가할 수 있음
    let emailValid : BehaviorSubject<Bool> = BehaviorSubject(value: false)
    let pwValid : BehaviorSubject<Bool> = BehaviorSubject(value: false)
    let emailInputText : BehaviorSubject<String> = BehaviorSubject(value: "")
    let pwInputText : BehaviorSubject<String> = BehaviorSubject(value: "")
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var pwTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var emailVaildView: UIView!
    
    @IBOutlet weak var pwVaildView: UIView!
    
    
    //MARK : - Bind UI
    private func bindInput() {
        //input : 아이디 입력, 비번 입력
        emailTextField.rx.text.orEmpty
            .bind(to: emailInputText )
            .disposed(by: disposeBag)
        
        emailInputText.map(checkEmailValid)
            .bind(to : emailValid)
            .disposed(by: disposeBag)
        
        
        pwTextField.rx.text.orEmpty
            .bind(to: pwInputText )
            .disposed(by: disposeBag)
        
        pwInputText.map(checkPwValid)
            .bind(to : pwValid)
            .disposed(by: disposeBag)
        
    }
    
    private func bindOutput() {
        //output : 불릿, 로그인버튼이네이블
        emailValid.subscribe(onNext : { b in
                        self.emailVaildView.isHidden = b
                }).disposed(by: disposeBag)
        
        pwValid.subscribe(onNext : { b in
                self.pwVaildView.isHidden = b
            }).disposed(by: disposeBag)
        
        Observable.combineLatest(
            emailValid,
            pwValid, resultSelector: { (s1, s2) in
                s1 && s2
            })
            .subscribe(onNext: { b in
                self.loginButton.isEnabled = b
            })
            .disposed(by: disposeBag)
        
    }
        
        
        
        
//        emailTextField.rx.text.orEmpty
//            .map(checkEmailValid)
//            .subscribe(onNext : { b in
//                self.emailVaildView.isHidden = b
//        }).disposed(by: disposeBag)
//
//        pwTextField.rx.text.orEmpty
//            .map(checkPwValid)
//            .subscribe(onNext : { b in
//                self.pwVaildView.isHidden = b
//        }).disposed(by: disposeBag)
//
//        Observable.combineLatest(
//            emailTextField.rx.text.orEmpty.map(checkEmailValid),
//            pwTextField.rx.text.orEmpty.map(checkPwValid), resultSelector: { (s1, s2) in
//                s1 && s2
//        })
//            .subscribe(onNext: { b in
//                self.loginButton.isEnabled = b
//            })
//            .disposed(by: disposeBag)
        
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.loginButton.isEnabled = false
        bindInput()
        bindOutput()
        
    }
    
    
    
    
    private func checkEmailValid( _ email: String) -> Bool {
        return email.contains("@") && email.contains(".")
    }
    private func checkPwValid( _ pw: String) -> Bool {
        return pw.count > 5
    }


}

