//
//  API.swift
//  UrlSessionLesson
//
//  Created by Юрий Нориков on 06.11.2019.
//  Copyright © 2019 Константин Богданов. All rights reserved.
//

import UIKit

class API {
    
    private static let apiKey = "dab4052df3cc23ed39745a8cca163e0a"
    private static let baseURL = "https://www.flickr.com/services/rest/"
    
    static func searchPath(text:String, extras: String, page: String) ->URL{
        guard var components = URLComponents(string: baseURL) else {
            return URL(string: baseURL)!
        }
        
        let methodItem = URLQueryItem(name: "method", value: "flickr.photos.search")
        let apiKeyItem = URLQueryItem(name: "api_key", value: apiKey)
        let textItem = URLQueryItem(name: "text", value: text)
        let formatItem = URLQueryItem(name: "format", value: "json")
        let extrasItem = URLQueryItem(name: "extras", value: extras)
        let nojsoncallbackItem = URLQueryItem(name: "nojsoncallback", value: "1")
        let pageIteamCount = URLQueryItem(name: "par_item", value: "30")
        let pageItem = URLQueryItem(name: "page", value: page)
        
        components.queryItems = [methodItem,apiKeyItem,textItem,formatItem,nojsoncallbackItem, extrasItem, pageIteamCount, pageItem]
        
        return components.url!
        
    }
    
}
