//
//  NotiDetailViewController.swift
//  passData2
//
//  Created by 허두영 on 2022/01/11.
//

import UIKit

class NotiDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    let notificationName = Notification.Name("sendSomeString")
    let strDic = ["str":"noti string"]
    
    
    @IBAction func notiAction(_ sender: Any) {
        NotificationCenter.default.post(name: notificationName, object: nil,userInfo: strDic)
        self.dismiss(animated: true, completion: nil)
        //post : 노티피케이션이름으로 호출
    }
    
}
