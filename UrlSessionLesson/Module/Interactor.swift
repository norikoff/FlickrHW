//
//  Interactor.swift
//  UrlSessionLesson
//
//  Created by Константин Богданов on 06/11/2019.
//  Copyright © 2019 Константин Богданов. All rights reserved.
//

import UIKit

protocol InteractorInput {
	func loadImageList(by searchString: String, pageNumber: UInt, completion: @escaping ([ImageModel]) -> Void)
	func loadImage(at path: String, completion: @escaping (UIImage?) -> Void)
//    func loadData(completion: @escaping ([ImageModel]?) -> Void)
}

class Interactor: InteractorInput {
//    func loadData(completion: @escaping ([ImageModel]?) -> Void) {
////        let decoder = JSONDecoder()
//        let url = API.searchPath(text: "cat", extras: "url_m")
//        networkService.getDataFromURL(at: url, parameters: nil) { data in
//            guard let data = data else { return }
////            do {
////
//////                let people = try decoder.decode([Model].self, from: data)
////                print(json)
////            } catch {
////                print(error.localizedDescription)
////            }
//            let json = try? JSONSerialization.jsonObject(with: data, options: .init()) as? Dictionary<String, Any>
//            guard let js = json,
//                let photoDict = js["photos"] as? Dictionary <String,Any>,
//                let arr = photoDict["photo"] as? [[String:Any]]
//                else{
//                    completion([])
//                    return}
//            let model = arr.map({(da) -> ImageModel in
//                let id = da["url_m"] as? String ?? ""
//                let server = da["title"] as? String ?? ""
//                return ImageModel(path: id, description: server)
//                })
//            print(model)
//
//            completion(model)
//        }
//    }
    
    func loadImageList(by searchString: String, pageNumber: UInt, completion: @escaping ([ImageModel]) -> Void) {
        let url = API.searchPath(text: searchString, extras: "url_m", page: String(pageNumber))
        networkService.getData(at: url) { data in
            guard let data = data else {
                completion([])
                return
            }
            let responseDictionary = try? JSONSerialization.jsonObject(with: data, options: .init()) as? Dictionary<String, Any>
            
            guard let response = responseDictionary,
                let photosDictionary = response["photos"] as? Dictionary<String, Any>,
                let photosArray = photosDictionary["photo"] as? [[String: Any]] else {
                    completion([])
                    return
            }
            
            let models = photosArray.map { (object) -> ImageModel in
                let urlString = object["url_m"] as? String ?? ""
                let    title = object["title"] as? String ?? ""
                return ImageModel(path: urlString, description: title)
            }
            completion(models)
        }
    }
    
	let networkService: NetworkServiceInput

	init(networkService: NetworkServiceInput) {
		self.networkService = networkService
	}

	func loadImageList(completion: [ImageModel]) {
        
	}

	func loadImage(at path: String, completion: @escaping (UIImage?) -> Void) {
		networkService.getData(at: path, parameters: nil) { data in
			guard let data = data else { return }
			let image = UIImage(data: data)
			completion(image)
		}
	}
}

extension InteractorInput {
    func loadImageList(by searchString: String, completion: @escaping ([ImageModel]) -> Void) {
        loadImageList(by: searchString, pageNumber: 1, completion: completion)
    }
}
