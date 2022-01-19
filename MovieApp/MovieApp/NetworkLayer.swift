//
//  NetworkLayer.swift
//  MovieApp
//
//  Created by 허두영 on 2022/01/19.
//

import Foundation

enum MovieAPIType {
    case justURL(urlString: String)
    case searchMovie(querys: [URLQueryItem])
    
}

enum MovieAPIError : Error{
    case badURL
}


//보통은 네트워크매니저라 하고 레이어라고 이름 짓지는 않음
class NetworkLayer {
    
    //only url
    //url. + parameter

    typealias NetworkCompletion = (_ data:Data?,_ response: URLResponse?,_ error : Error?) -> Void
    
    // 언더바(_)는 클로저의 기본규칙
    func request(type : MovieAPIType, completion: @escaping NetworkCompletion ) {
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        //throw를 사용하면 try 키워드가 필요 (예외 처리)
        do {
            let request = try buildRequest(type: type)
            session.dataTask(with: request) { (data, response, error) in
                print((response as! HTTPURLResponse).statusCode)
                
                completion(data,response,error)
                
                
                
                
                
            }.resume()
            session.finishTasksAndInvalidate()
        } catch {
            //try에서 실패하면 catch로 옴
            print(error)
        }
    
        
        
    }
    
    //옵셔널로해서 닐을 받으면 어떻게 잘못됬는지 알기 힘듬
    //에러 확인을 쉽게하기 위해 throws로 에러 처리
    func buildRequest(type : MovieAPIType) throws -> URLRequest {
            
            //타입한테 받아서 갖고있는 값이 있는 파라미터가 있는 경우 스위치가 유용
            switch type {
            case .justURL(urlString: let urlString):
                guard let hasURL = URL(string: urlString) else{
                    throw MovieAPIError.badURL
                }
                var request = URLRequest(url: hasURL)
                request.httpMethod = "GET"
                return request
                
            case .searchMovie(querys: let querys):
                var components = URLComponents(string: "https://itunes.apple.com/search")
                
                components?.queryItems = querys
                
                guard let hasUrl = components?.url else{
                    throw MovieAPIError.badURL
                }
                var request = URLRequest(url: hasUrl)
                request.httpMethod = "GET"
                return request
                
            }
            
        }
}
