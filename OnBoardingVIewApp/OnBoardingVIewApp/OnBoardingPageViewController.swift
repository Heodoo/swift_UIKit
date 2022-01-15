
//xib기반 vs 순수하게 코딩 ,xib로 하면 인스펙터에서 따로 체크하는 과정이 필요
//이번엔 코딩으로만 진행

import UIKit

class OnBoardingPageViewController: UIPageViewController {
    
    var pages = [UIViewController]()
    
    var bottomButtonMargin : NSLayoutConstraint?
    
    var pageControl = UIPageControl()
    
    let startIndex = 0
    //값으 받을떄마다 didSet을 호출
    var currentIndex = 0 {
        didSet {
            pageControl.currentPage = currentIndex
        }
    }
    
    func makePageVC(){
        
        let itemVC1 = OnBoardingItemViewController.init(nibName: "OnBoardingItemViewController", bundle: nil)
        itemVC1.mainText = "첫번째"
        itemVC1.topImage = UIImage(named: "onboarding1")
        itemVC1.subText = "1111"
       
        
        let itemVC2 = OnBoardingItemViewController.init(nibName: "OnBoardingItemViewController", bundle: nil)
        
        itemVC2.mainText = "두번째"
        itemVC2.topImage = UIImage(named: "onboarding2")
        itemVC2.subText = "2222"
       
        let itemVC3 = OnBoardingItemViewController.init(nibName: "OnBoardingItemViewController", bundle: nil)
        itemVC3.mainText = "세번째"
        itemVC3.topImage = UIImage(named: "onboarding3")
        itemVC3.subText = "3333"
       
        
        
        pages.append(itemVC1)
        pages.append(itemVC2)
        pages.append(itemVC3)
        
        //UIPageViewController 사용시 기본페이지를 꼭 설정해야함
        setViewControllers([itemVC1], direction: .forward, animated: true, completion: nil)
        
        
        self.dataSource = self
        self.delegate = self
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        itemVC1.mainTitleLabel.text = "첫번째"//에러 화면을 불러오는데 더 시간이 걸리기 때문에 메인뷰컨트롤러에서 viewDidload 전에 불러와서 에러 발생
        self.makePageVC()
        self.makeBottomButton()
        self.makePageControl()
    
        
        
    }
    //xib없이 코드로 버튼만들기
    func makeBottomButton() {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(dissmissPageVC), for: .touchUpInside)
        
        
        self.view.addSubview(button)
        //오토레이아웃설정을 하려면 기본으로 false를 주어야 함
        button.translatesAutoresizingMaskIntoConstraints = false
        //.isActiive = ture 를 해줘야 활성화가 되므로 꼭 필요함
        
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //safe area가 존재하는 아이폰의 경우 아래나 위에 붙일떄 safe area를 고려해야함
        //self.view.safeAreaLayoutGuide으로 접근
        bottomButtonMargin = button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        bottomButtonMargin?.isActive = true
        hideButton()
        //isActive를 false하고 다시 true 하면서 버튼을 숨기거나 나타낼 수 있지만 코딩량이 많아짐
        //따라서 콘스탄트를 잘 조절하자
    }
    
    @objc func dissmissPageVC(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func makePageControl() {
        //pageControl 추가
        self.view.addSubview(pageControl)
        //오토레이아웃 설정하기위해
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.numberOfPages = pages.count
        //좋은 코딩 습관, 그냥 네이밍없이 상수처리하면 알아보기 힘듬, 고정된 값은 변수 따로 추가
        pageControl.currentPage = startIndex
        pageControl.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        pageControl.addTarget(self, action: #selector(pageControlTapped), for: .valueChanged)
        
        
        
        // 유저가 터치하거나 하는 상호작용을 아예 꺼버리기
        //pageControl.isUserInteractionEnabled = false
    }
    @objc func pageControlTapped(sender : UIPageControl) {
        if sender.currentPage > self.currentIndex {
            self.setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
        }else {
            self.setViewControllers([pages[sender.currentPage]], direction: .reverse, animated: true, completion: nil)
        }
        self.currentIndex = sender.currentPage
        buttonPresentationStyle()
    }


}

extension OnBoardingPageViewController : UIPageViewControllerDataSource {
    //현재에서 이전으로갈 페이지는 뭐냐
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        //인덱스값은 보통 옵셔널이므로 guard let 사용
        guard let currentIndex = pages.firstIndex(of: viewController) else{
            return nil
        }
        
        self.currentIndex = currentIndex
        
        if currentIndex == 0 {
            return pages.last
        }else{
            return pages[currentIndex-1]
        }
    }
    //현재에서 다음페이지로 갈 페이지는 뭐냐
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.lastIndex(of: viewController) else{
            return nil
        }
        self.currentIndex = currentIndex
        if currentIndex == pages.count - 1 {
            return pages.first
        }else{
            return pages[currentIndex+1]
        }
        
    }
    
    
    
    
}

extension OnBoardingPageViewController : UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentVC = pageViewController.viewControllers?.first else {
            return
        }
        guard let currentIndex = pages.firstIndex(of: currentVC) else {
            return
        }
        self.currentIndex = currentIndex
        buttonPresentationStyle()

    }
    
    func buttonPresentationStyle() {
        if currentIndex == pages.count - 1 {
            //show Button
            //bottomButtonMargin?.constant = 0
            // 이렇게 수치로 적어놓으면 나중에 알아보기 힘듬 따로 함수름 만들어서 가독성 업
            self.showButton()
        }else{
            //hide button
            self.hideButton()
        }
        //변경된 값이 0.5초후에 진행
//        UIView.animate(withDuration: 0.5){
//            self.view.layoutIfNeeded()
//        }
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: [.curveEaseInOut],animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)

    }
    func showButton() {
        bottomButtonMargin?.constant = 0
    }
    
    func hideButton(){
        
        bottomButtonMargin?.constant = 100
    }
}
