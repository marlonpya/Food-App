//
//  URLUtil.swift
//  Food App
//
//  Created by marlon arteaga on 14/09/23.
//

import Foundation

struct URLConstants {
    
    static let scheme = "http"
    static let path = "api.punkapi.com/v2/beers"
    
}

extension URL {
    
    static func getBeers(page:String, perPage: String) -> URL {
        var component = URLComponents()
        component.scheme = URLConstants.scheme
        component.path = URLConstants.path
        component.queryItems = [
            URLQueryItem(name: "page", value: page),
            URLQueryItem(name: "per_page", value: perPage)
        ]
        return component.url!
    }
    
    static func getBeers(food: String) -> URL {
        var component = URLComponents()
        component.scheme = URLConstants.scheme
        component.path = URLConstants.path
        component.queryItems = [
            URLQueryItem(name: "food", value:food)
        ]
        return component.url!
    }
    
    static func getBeers(page:String, perPage: String, food: String) -> URL {
        var component = URLComponents()
        component.scheme = URLConstants.scheme
        component.path = URLConstants.path
        component.queryItems = [
            URLQueryItem(name: "page", value: page),
            URLQueryItem(name: "per_page", value: perPage)
        ]
        if !food.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            component.queryItems?.append(URLQueryItem(name: "food", value: food))
        }
        return component.url!
    }
}
