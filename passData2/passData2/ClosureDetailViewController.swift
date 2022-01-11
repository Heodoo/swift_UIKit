//
//  ClosureDetailViewController.swift
//  passData2
//
//  Created by 허두영 on 2022/01/11.
//

import UIKit

class ClosureDetailViewController: UIViewController {
    
    var myClosure: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func closurePassData(_ sender: Any) {
        myClosure?("closure string")
        self.dismiss(animated: true, completion: nil)
    }
}
