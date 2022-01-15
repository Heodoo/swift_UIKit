//
//  ViewController.swift
//  OnBoardingVIewApp
//
//  Created by 허두영 on 2022/01/14.
//

import UIKit

class ViewController: UIViewController {
    
    var didShowOnBoardingView = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //메인화면이 보이려고할떄 계속 호출
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    //1번 화면이 나타났을때 그려줘야함, 그전에하면 에러(위에서 밑에 코드 실행시 에러발생)
    //메인화면이 보였을때 계속 호출
    //그래서 상태값(didShowOnBoardingView 값)을 만들어 조절 프로젝트규모가 커지면 유저정보에 따로 설정, 여기서는 간단히 메모리 값을 하나 만들어 조절함
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if didShowOnBoardingView == false {
            didShowOnBoardingView = true
            //1번
            //        let itemVC = OnBoardingItemViewController.init(nibName: "OnBoardingItemViewController", bundle: nil)
            //        self.present(itemVC, animated: true, completion: nil)
            
            //페이즈뷰컨트롤러를 화면에 띄우려면 먼저 인스턴스화
            let pageVC = OnBoardingPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: .none) // ()기본으로 하면 종이넘기는 방식으로 생성됨
            //pageVC.transitionStyle = .scroll , 만들어지기전에 스타일을 줘야함
            
            //전체화면으로
            pageVC.modalPresentationStyle = .fullScreen
            
            self.present(pageVC, animated: true, completion: nil)
        }
    }



}

