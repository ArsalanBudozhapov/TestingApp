//
//  NetworkService.swift
//  TestingApp
//
//  Created by мак on 05.09.2022.
//

import Foundation


class NetworkService {
    
    func request(searchTerm: String, completion: @escaping (Data?, Error?) -> Void)  {
        
        let parameters = self.prepareParameteres(searchTerm: searchTerm)
        let url = self.url(params: parameters)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    func randomRequest(completion: @escaping (Data?, Error?) -> Void){
        let parameters = self.prepareRandomParams()
        let url = self.urlRandom(params: parameters)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    func RequestByID(id: String, completion: @escaping (Data?, Error?) -> Void){
        let url = self.url_photo_id(id: id)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func prepareHeader() -> [String: String]? {
        var headers = [String: String]()
        headers["Authorization"] = "Client-ID M5tAEzUt8S8cfibgNnrB0SFHd0-IDHd2Zyy4miOeIHI"
        return headers
    }
    
    private func prepareParameteres(searchTerm: String?) -> [String: String] {
        var parameters = [String: String]()
        parameters["query"] = searchTerm
        parameters["page"] = String(1)
        parameters["per_page"] = String(30)
        return parameters
    }
    
    private func prepareRandomParams() -> [String:String]{
        var parameters = [String: String]()
        parameters["count"] = String(30)
        parameters["content_filter"] = "high"
        return parameters
    }
    
    private func url(params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/search/photos"
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1)}
        return components.url!
    }
    
    private func url_photo_id(id: String) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/photos/\(id)"
        return components.url!
    }
    
    private func urlRandom(params: [String:String]) -> URL{
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/photos/random"
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1)}
        return components.url!
        
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data? , Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}

