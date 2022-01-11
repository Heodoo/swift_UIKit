//
//  ViewController.swift
//  passData2
//
//  Created by 허두영 on 2022/01/11.
//
//segue 여러개의 뷰컨트롤러가 하나에 스토리보드에 있을떄 많이 사용
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationName = Notification.Name("sendSomeString")
        // OS쪽에서 앱을 감지하는? 기능을 하는 NotificaitonCenter
        NotificationCenter.default.addObserver(self, selector: #selector(showSomeString), name: notificationName, object: nil)
        //addObserver 사용시 여러번 불리지 않도록 주의! 등록을 두번하면 두번 호출됨
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
       
    }
    @objc func keyboardWillShow() {
        print("will show")
    }
    
    @objc func showSomeString(notification: Notification) {
        if let str = notification.userInfo?["str"] as? String{
            self.dataLabel.text = str
        }
    }
    
    
    
    @IBOutlet weak var dataLabel: UILabel!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetail" {
            if let detailVC = segue.destination as? SegueDetailViewController {
                //detailVC.dataLabel.text = "segue값을 받았습니다"//화면에 올릴상태가 아닌 상태에서 IBOulet을 불러오기 때문에
                detailVC.dataString = "segue"
            }
        }
    }
    
    @IBAction func moveDetail(_ sender: Any) {
        let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
        
        //detailVC.someString = "aaa data"
        
        //화면에 올릴 준비(presnet)를 하기전에 데이터를 보내면 에러
        //detailVC.someLabel.text = "bb"
        
        self.present(detailVC, animated: true, completion: nil)// detailVC 화면으로 이동
        
        //present 이후에 해야 에러 안생김
        detailVC.someLabel.text = "bb"
        
    }
    
    @IBAction func moveToInstance(_ sender: Any) {
        let detailVC = InstanceDetailViewController(nibName: "InstanceDetailViewController", bundle: nil)
        
        //나 자신을 mainVC에 연결
        detailVC.mainVC = self
        
        self.present(detailVC, animated: true, completion: nil)
    }
    
    //보내는곳 받아야하는곳 둘다설정 대신 만들어주는
    @IBAction func moveToDelegate(_ sender: Any) {
        let detailVC = DelegateDetailViewController(nibName: "DelegateDetailViewController", bundle: nil)
        detailVC.delegate = self// 타입이 맞아야 들어갈 수 있음 프로토콜 규격을 맞춰줘야함
        self.present(detailVC, animated: true, completion: nil)
    }
    
    //구현부 호출부 분리
    @IBAction func moveToClosure(_ sender: Any) {
        let detailVC = ClosureDetailViewController(nibName: "ClosureDetailViewController", bundle: nil)
        
        detailVC.myClosure = { str in
            self.dataLabel.text = str
        }//델리게이트의 extension부분 구현부와 비슷함
        self.present(detailVC, animated: true, completion: nil)
    }
    
    
    @IBAction func moveToNoti(_ sender: Any) {
        let detailVC = NotiDetailViewController(nibName: "NotiDetailViewController", bundle: nil)
        present(detailVC, animated: true, completion: nil)
    }
    
}
//프로토콜 구현부
extension ViewController: DelegateDetailViewControllerDelegate {
    func passString(string: String) {
        self.dataLabel.text = string
    }//DelegateDetailViewController 와는 여기만 연결됨
    //self가 아무리 많은 정보를 가져도 타입이 맞는 부분만 연결됨
    
}

