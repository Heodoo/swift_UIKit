//
//  ViewController.swift
//  MovieApp
//
//  Created by 허두영 on 2022/01/16.
//

import UIKit

class ViewController: UIViewController {
    
    var movieModel: MovieModel?
    
    var term = ""
    
    var networkLayer = NetworkLayer()
    @IBOutlet weak var movieTableView: UITableView!
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        movieTableView.delegate = self
        movieTableView.dataSource = self
        movieTableView.keyboardDismissMode = .onDrag
        searchBar .delegate = self
        
        requestMovieAPI()
    }
    
    private
    
    func loadImage(urlString : String, completion: @escaping (UIImage?) -> Void){
        networkLayer.request(type: .justURL(urlString: urlString)) { (data, response, error) in
            if let hasData = data {
                completion(UIImage(data: hasData))
                return
            }
            completion(nil)
        }
    }
    
    
    // network 호출 (여기서는 애플기본형식으로 사용 but 보통 코코아팟이나 alamofire 등 오픈소스로 더 쉽게 가능, 구조는 거의 비슷)
    func requestMovieAPI() {
        let term = URLQueryItem(name: "term", value: self.term)
        let media = URLQueryItem(name: "media", value: "movie")
        let querys = [term,media]
        
        networkLayer.request(type: .searchMovie(querys: querys)) { (data, response, error) in
            if let hasData = data{
                do {
                    self.movieModel =  try JSONDecoder().decode(MovieModel.self, from: hasData)
                    
                    print(self.movieModel ?? "No Data")
                    //갱신은 메인스레드에서만, 그리고 클로저안에 있으므로 기본으로 메인스레드로 안잡힘
                    DispatchQueue.main.async {
                        self.movieTableView.reloadData()
                    }
                }catch{
                    print(error)
                }
                
            }
        }
        
    }
}
extension ViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = UIStoryboard(name: "DetailViewController", bundle: nil).instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        
        //선택된 셀에 눌린자국 없어지는 기능
        tableView.deselectRow(at: indexPath, animated: true)
        
        detailVC.movieResult = self.movieModel?.results[indexPath.row]
        //fullscreen으로 할때는 닫는버튼이 꼭 필요
        detailVC.modalPresentationStyle = .fullScreen
        self.present(detailVC, animated: true, completion: nil)
        
        //        self.present(detailVC, animated: true) {
        //            //completion을 이용하여 화면이 띄어지고 값을 보내야 에러안남
        //            detailVC.movieResult = self.movieModel?.results[indexPath.row]
        //        }
    }
    
    
    
    //네트워트간 데이터를 주고받는 경우가 자주발생, 겹치는 코드가 많이 생김
    //NetworkLayer.swift를 만들어 네트워크 부분을 따로 작업 (리팩토링)
    //    func loadImage(urlString : String, completion: @escaping (UIImage?) -> Void){
    //        let sessionConfig = URLSessionConfiguration.default
    //        let session = URLSession(configuration: sessionConfig)
    //
    //        if let hasURL = URL(string: urlString){
    //            var request = URLRequest(url: hasURL)
    //            request.httpMethod = "GET"
    //
    //            session.dataTask(with: request) { (data, response, error) in
    //                print((response as! HTTPURLResponse).statusCode)
    //                //클로저안에서는 리턴 불가 따라서 함수인자에 클로저를 생성하여 값을 받자(completion)
    //                if let hasData = data {
    //                    completion(UIImage(data: hasData))
    //                    return
    //                }
    //            //세션을 시작하고 끝내는 부분이 필요
    //            }.resume()
    //            session.finishTasksAndInvalidate()
    //        }
    //        //이 코드가없으면 메모리에 계속 남음 끝날수있게 꼭 nil을 넣어줘야함
    //        completion(nil)
    //
    //
    //    }
    //
    //
    //    // network 호출 (여기서는 애플기본형식으로 사용 but 보통 코코아팟이나 alamofire 등 오픈소스로 더 쉽게 가능, 구조는 거의 비슷)
    //    func requestMovieAPI() {
    //        let sessionConfig = URLSessionConfiguration.default
    //        let session = URLSession(configuration: sessionConfig)
    //
    //        var components = URLComponents(string: "https://itunes.apple.com/search")
    //
    //        let term = URLQueryItem(name: "term", value: self.term)
    //        let media = URLQueryItem(name: "media", value: "movie")
    //
    //        components?.queryItems = [term,media]
    //        guard let url = components?.url else {
    //            return
    //        }
    //
    //        var request = URLRequest(url: url)
    //        request.httpMethod = "GET"
    //
    //        let task = session.dataTask(with: request) { data, response, error in
    //            print((response as! HTTPURLResponse).statusCode)
    //            if let hasData = data{
    //                do {
    //                    self.movieModel =  try JSONDecoder().decode(MovieModel.self, from: hasData)
    //
    //                    print(self.movieModel ?? "No Data")
    //                    //갱신은 메인스레드에서만, 그리고 클로저안에 있으므로 기본으로 메인스레드로 안잡힘
    //                    DispatchQueue.main.async {
    //                        self.movieTableView.reloadData()
    //                    }
    //                }catch{
    //                    print(error)
    //                }
    //
    //            }
    //        }
    //        task.resume()
    //        session.finishTasksAndInvalidate()
    //
    //
    //    }
    //
    //
    //}
    //extension ViewController : UITableViewDelegate,UITableViewDataSource{
    //
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        let detailVC = UIStoryboard(name: "DetailViewController", bundle: nil).instantiateViewController(identifier: "DetailViewController") as! DetailViewController
    //
    //        //선택된 셀에 눌린자국 없어지는 기능
    //        tableView.deselectRow(at: indexPath, animated: true)
    //
    //        detailVC.movieResult = self.movieModel?.results[indexPath.row]
    //        //fullscreen으로 할때는 닫는버튼이 꼭 필요
    //        detailVC.modalPresentationStyle = .fullScreen
    //        self.present(detailVC, animated: true, completion: nil)
    //
    ////        self.present(detailVC, animated: true) {
    ////            //completion을 이용하여 화면이 띄어지고 값을 보내야 에러안남
    ////            detailVC.movieResult = self.movieModel?.results[indexPath.row]
    ////        }
    //    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieModel?.results.count ?? 0
    }
    //최신 ios는 자동으로 콘텐츠크기만큼 높이를 맞춰주지만 이전 ios는 밑에처럼 따로 설정이 필요
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        //받은 api 데이터들을 화면으로 전송하기
        cell.titleLabel.text = self.movieModel?.results[indexPath.row].trackName
        cell.descriptionLabel.text = self.movieModel?.results[indexPath.row].shortDescription
        
        let currency = self.movieModel?.results[indexPath.row].currency ?? ""
        
        let price = self.movieModel?.results[indexPath.row].trackPrice?.description ?? ""
        cell.priceLabel.text = currency + price
        if let hasURL = self.movieModel?.results[indexPath.row].image {
            
            self.loadImage(urlString: hasURL) { (image) in
                DispatchQueue.main.async {
                    cell.movieImageView.image = image
                }
                
            }
            
        }
        
        if let dateString = self.movieModel?.results[indexPath.row].releaseDate {
            let formatter = ISO8601DateFormatter()
            
            if let isoDate = formatter.date(from: dateString) {
                let myFormatter = DateFormatter()
                myFormatter.dateFormat = "yyyy년 MM월 dd일"
                let dateString = myFormatter.string(from: isoDate)
                cell.dateLabel.text = dateString
            }
            
            
        }
        
        
        return cell
    }
    
    
    
}

//서치바
extension ViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //값이 있을 때만 가져오기 위해 guard let 사용
        guard let hasText = searchBar.text else{
            return
        }
        term = hasText
        requestMovieAPI()
        //키보드 내리기
        self.view.endEditing(true)
    }
}



