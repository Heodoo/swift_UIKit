//앱의 실제적인 구성을 관리

import UIKit

class ViewController: UIViewController {
    

    var settingModel = [[SettingModel]]()
    
    
    //세팅모델에 데이터추가
    func makeData() {
        settingModel.append(
        [SettingModel(leftImageName: "person.circle", menuTitle: "Sign in your iPhone", subTitle: "Set up iCloud, the App Store, and more.", rightImageName: "chevron.right")]
        )
        settingModel.append([SettingModel(leftImageName: "gear", menuTitle: "General", subTitle: nil, rightImageName: "chevron.right"),SettingModel(leftImageName: "person.fill", menuTitle: "Accessibility", subTitle: nil, rightImageName: "chevron.right"),SettingModel(leftImageName: "hand.raised.fill", menuTitle: "Privacy", subTitle: nil, rightImageName: "chevron.right")])
        

        
    }
    
    @IBOutlet weak var settingTableVIew: UITableView!
    
    //화면에 나오면 실행
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingTableVIew.delegate = self
        settingTableVIew.dataSource = self
        settingTableVIew.backgroundColor = UIColor(white: 245/255, alpha: 1)
        
        settingTableVIew.register(UINib(nibName: "ProfileCell",bundle: nil), forCellReuseIdentifier: "ProfileCell")//nib = xib파일들
        settingTableVIew.register(UINib(nibName: "MenuCell",bundle: nil), forCellReuseIdentifier: "MenuCell")
    
        title = "Settings"
        //navigationController?.navigationBar.prefersLargeTitles = true
        self.view.backgroundColor =  UIColor(white: 245/255, alpha: 1)
        makeData()
       
    }


}
extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingModel[section].count
        //섹션의 개수를 맞춰줌
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingModel.count
    }
    //셀을 눌렀을떄 작동하는 기능 추가 didSelctRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //누른 후에 눌려있는 동작을 없앰
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 && indexPath.row == 0 {
            let myuiVC =
                MyUIViewController(nibName: "MyUIViewController", bundle: nil)
            self.present(myuiVC, animated: true, completion: nil)
        }
        
        
        else if indexPath.section == 1 && indexPath.row == 0 {
            if let generalVC = UIStoryboard(name: "GeneralViewController", bundle: nil).instantiateViewController(identifier: "GeneralViewController") as? GeneralViewController{
                self.navigationController?.pushViewController(generalVC, animated: true)
            }
            //이 스토리보드에서 이 아이디를 가진 뷰컨트롤러를 가져오겠다
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
            //강제 타입캐스팅을 하지않으면 자동입력불가, cell 은 기본적으로 UItableViewCell이므로 가져온 cell을 사용하려면 ProfileCell 로 타입캐스팅 필요
            cell.topTitle.text = settingModel[indexPath.section][indexPath.row].menuTitle
            cell.profileImageView.image =
            UIImage(systemName: settingModel[indexPath.section][indexPath.row].leftImageName)
            
            cell.bottomDescription.text = settingModel[indexPath.section][indexPath.row].subTitle
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        
        cell.leftImageView.image = UIImage(systemName: settingModel[indexPath.section][indexPath.row].leftImageName)
        cell.leftImageView.tintColor = .red
        cell.rightImageView.image = UIImage(systemName: settingModel[indexPath.section][indexPath.row].rightImageName ?? "") //systemName: 는 옵셔널값 불가능 그래서 옵셔널일 경우 빈스트링
        cell.middleTitle.text = settingModel[indexPath.section][indexPath.row].menuTitle
        return cell
        
    }
    
    func tableView(_ tableView: UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            //첫번쨰는 간격 자동으로 맞추고
            return UITableView.automaticDimension
        }
        //나머지는 60으로 고정
        return 100
    }
    //tableView 각 고정간격 설정,특정한 높이로 지정
    /*
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        return 160

    }
    */
}
