//
//  InstanceDetailViewController.swift
//  passData2
//
//  Created by 허두영 on 2022/01/11.
//

import UIKit

class InstanceDetailViewController: UIViewController {

    var mainVC : ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //버튼을 눌렀을 때 mainviewcontroller에 접근해서 값을 변경하기
    @IBAction func sendDataMainVc(_ sender: Any) {
        mainVC?.dataLabel.text = "some data"
        self.dismiss(animated: true, completion: nil)//화면 종료
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
