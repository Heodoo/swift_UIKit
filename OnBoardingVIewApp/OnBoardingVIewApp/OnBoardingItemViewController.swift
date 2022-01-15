//
//  OnBoardingItemViewController.swift
//  OnBoardingVIewApp
//
//  Created by 허두영 on 2022/01/14.
//

import UIKit

class OnBoardingItemViewController: UIViewController {
    
    var mainText = ""
    var subText = ""
    var topImage : UIImage? = UIImage()
    
    
    @IBOutlet private weak var descriptionLabel: UILabel!{
        didSet{
            descriptionLabel.font = UIFont.systemFont(ofSize: 10, weight: .light)
        }
    }
    
    @IBOutlet private weak var topImageVIew: UIImageView!
    
    
    @IBOutlet private weak var mainTitleLabel: UILabel!{
        didSet{
            mainTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //모든객체가 생성되고 난 이후
        mainTitleLabel.text = mainText
        descriptionLabel.text = subText
        topImageVIew.image = topImage
        
    }

}
