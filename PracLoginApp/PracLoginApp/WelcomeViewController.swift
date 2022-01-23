//
//  WelcomeViewController.swift
//  PracLoginApp
//
//  Created by 허두영 on 2022/01/23.
//

import UIKit

class WelcomeViewController: UIViewController {
    let welcomeLabel = UILabel()
    let closeButton = UIButton()
    var bottomButtonMargin : NSLayoutConstraint?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        makeWelcomeLabel()
        makeCloseButton()
    }
    
    func makeWelcomeLabel(){
        welcomeLabel.text = "Welcome"
        welcomeLabel.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(welcomeLabel)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        welcomeLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    func makeCloseButton(){
        
        closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
        closeButton.backgroundColor = .systemBlue
        closeButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        
        self.view.addSubview(closeButton)
        //오토레이아웃설정을 하려면 기본으로 false를 주어야 함
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        //.isActiive = ture 를 해줘야 활성화가 되므로 꼭 필요함
        
        closeButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        closeButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        closeButton.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

        bottomButtonMargin = closeButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        bottomButtonMargin?.isActive = true
    }
    
    @objc func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
