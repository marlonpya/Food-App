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

class RemoteManager {
    static let shared = RemoteManager()
    
    func fetchBeers(page: String, perPage: String, food: String, completed: @escaping(Result<[DataModel], ApiError>) -> Void) {
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
    
    func fetchBeers(food: String, completed: @escaping(Result<[DataModel], ApiError>) -> Void) {
        let foodReplace = food.replacingOccurrences(of: " ", with: "_")
        var request = URLRequest(url: URL.getBeers(food: foodReplace))
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
