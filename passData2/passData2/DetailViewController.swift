//
//  DetailViewController.swift
//  passData2
//
//  Created by 허두영 on 2022/01/11.
//

import UIKit

class DetailViewController: UIViewController {

    var someString = ""//property는 바로 생성됨
    
    //IBOulet은 화면에 올리기전에는 항상 nil임, 화면에 올라갈 준비가 됐을 떄 생성됨
    @IBOutlet weak var someLabel: UILabel!
    //nil 일떄 옵셔널이므로 크래쉬가 생김
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        someLabel.text = someString

        // Do any additional setup after loading the view.
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
