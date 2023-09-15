//
//  RemoteManager.swift
//  Food App
//
//  Created by marlon arteaga on 14/09/23.
//

import Foundation

enum ApiError: Error {
    case error
    case unknow
    case notFound
}

class RemoteManager/*: ObservableObject*/ {
    static let shared = RemoteManager()
    
    //@Published var list = [DataModel]()
    //@Published var filterList = [DataModel]()
    
    /*func getDataFromRemote() {
        
        var request = URLRequest(url: URL.getBeers(page: String(currentPage), perPage: String(Constants.perPage)))
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil {
                if data != nil {
                    do {
                        let jsonResponse = try JSONDecoder().decode([DataModel].self, from: data!)
                        DispatchQueue.main.sync {
                            self.list.append(contentsOf: jsonResponse)
                        }
                    } catch let exception {
                        print(exception)
                    }
                } else {
                    print("went wrong")
                }
            } else {
                print(error?.localizedDescription ?? "not found")
            }
        }
        task.resume()
    }*/
    
    func getBeer(page: String, perPage: String, completed: @escaping(Result<[DataModel], ApiError>) -> Void) {
        var request = URLRequest(url: URL.getBeers(page: page, perPage: perPage))
        request.httpMethod = "GET"
        print(request.url!.absoluteString)
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            do {
                let jsonResponse = try JSONDecoder().decode([DataModel].self, from: data!)
                completed(.success(jsonResponse))
            } catch let exception {
                print(exception)
                completed(.failure(.unknow))
            }
        }
        task.resume()
    }
    
    func getBeer(page: String, perPage: String, food: String, completed: @escaping(Result<[DataModel], ApiError>) -> Void) {
        let foodReplace = food.replacingOccurrences(of: " ", with: "_")
        var request = URLRequest(url: URL.getBeers(page: page, perPage: perPage, food: foodReplace))
        request.httpMethod = "GET"
        print(request.url!.absoluteString)
        
        let task =  URLSession.shared.dataTask(with: request) { (data, _, error) in
            do {
                let jsonResponse = try JSONDecoder().decode([DataModel].self, from: data!)
                completed(.success(jsonResponse))
            } catch let exception {
                print(exception)
                completed(.failure(.unknow))
            }
        }
        task.resume()
    }
}
