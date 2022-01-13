//
//  GeneralViewController.swift
//  Setting_Clone_App
//
//  Created by 허두영 on 2022/01/12.
//

import UIKit

//보통은 파일하나에 클래스 하나
class GeneralCell: UITableViewCell {
    
    @IBOutlet weak var leftLabel: UILabel!
    
    //고정된 하나의 이미지인 경우 didset 활용
    //xib쪽과 연결되어 객체가 생성되는 시점에서 didset이 호출
    @IBOutlet weak var rightImageView: UIImageView!{
        didSet{
            rightImageView.image = UIImage(systemName: "chevron.right")
            rightImageView.backgroundColor = .clear
            rightImageView.tintColor = .red
        }
    }
}
//위 셀은 테이블뷰에 올려져 있는 형태이므로 메인뷰컨트롤러에서 처럼 셀을 register 등록 할 필요 없음
//델리게이트와 데이터소스정도만 연결하여 사용


//모델 자료구조는 보통 따로 파일을 만드는게 좋음, seetingModel.swift 처럼
struct GeneralModel {
    var leftTitle : String = ""
}

class GeneralViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //이중배열을 사용하여 그룹을 나눌수 있음
    //하드웨어설정에 대한 그룹, 기본정보그룹, 리셋그룹 이런식을
    var model = [[GeneralModel]]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model[section].count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GeneralCell", for: indexPath) as! GeneralCell
        
        cell.leftLabel.text = model[indexPath.section][indexPath.row].leftTitle
        
        return cell
    }
    

    @IBOutlet weak var generalTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "General"
        //내려도 상단에 큰 타이틀이 생기지 않게 변경
        self.navigationController?.navigationBar.prefersLargeTitles = false
        generalTableView.delegate = self
        generalTableView.dataSource = self
        generalTableView.backgroundColor = UIColor(white: 245/255, alpha: 1)
        
        
        model.append([GeneralModel(leftTitle: "About")])
        
        model.append([GeneralModel(leftTitle: "Keyboard"),
        GeneralModel(leftTitle: "Game Controller"),
        GeneralModel(leftTitle: "Fonts"),
        GeneralModel(leftTitle: "Language & Region"),
        GeneralModel(leftTitle: "Dictionary")])
        
        model.append([GeneralModel(leftTitle: "Reset")])
    }
    


}
