//
//  DetailViewController.swift
//  MovieApp
//
//  Created by 허두영 on 2022/01/18.
//

import UIKit
import AVKit

class DetailViewController: UIViewController {
    
    var player:AVPlayer?
    
    
    var movieResult: MovieResult?
//    {
//        didSet{
//            titleLabel.text = movieResult?.trackName ?? ""
//            descriptionLabel.text = movieResult?.longDescription
//        }
//    }
    
    
    
    @IBOutlet weak var movieContainer: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!{
        didSet{
            titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        }
    }
    
    
    @IBOutlet weak var descriptionLabel: UILabel!{
        didSet{
            descriptionLabel.font = .systemFont(ofSize: 16, weight: .light)
        }
    }
    
    // viewdidload 화면이 나오지 않은 준비가 된 상태, 화면이 나올 직전쯤
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = movieResult?.trackName
        descriptionLabel.text = movieResult?.longDescription
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let hasUrl = movieResult?.previewUrl{
            makePlayerAndPlay(urlString: hasUrl)
        }
    }
    
    
    func makePlayerAndPlay(urlString : String){
        if let hasUrl = URL(string: urlString){
            self.player = AVPlayer(url: hasUrl)
            let playerLayer = AVPlayerLayer(player: player)
            
            movieContainer.layer.addSublayer(playerLayer)
            
            //view와 달리 layer는 오트레이아웃 개념이 아예없음, 좌표와 절대값 개념만 있음
            
            playerLayer.frame = movieContainer.bounds
            
            //재생
            self.player?.play()
            
            
        }
        
        
        
    }
    

    @IBAction func play(_ sender: Any) {
        self.player?.play()
        
    }
    
    @IBAction func stop(_ sender: Any) {
        self.player?.pause()
        
    }
    
    @IBAction func close(_ sender: Any) {
        //present 와 dismiss 는 한 쌍
        self.dismiss(animated: true, completion: nil)
    }
    
}
