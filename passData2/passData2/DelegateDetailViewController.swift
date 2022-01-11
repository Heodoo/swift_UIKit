//
//  DelegateDetailViewController.swift
//  passData2
//
//  Created by 허두영 on 2022/01/11.
//

import UIKit

//델리게이트 패턴은 보통 프로토콜 규격을 준수하는것들만 사용가능
protocol DelegateDetailViewControllerDelegate : AnyObject {
    func passString(string: String)
}//프로토콜은 바디만 있고 내용을 추가할 수 없음

class DelegateDetailViewController: UIViewController {
//있을수도 없을수도 있으므로 옵셔널로 생성, 정의가 내려지는 곳이 다른 곳에 있기 때문에 정의가 내려지는 곳에서 사용하고 없어지는 weak 타입으로 생성
    weak var delegate : DelegateDetailViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func passDataToMainVC(_ sender: Any) {
        delegate?.passString(string: "delegate pass Data")
        self.dismiss(animated: true, completion: nil)
    }
}
