//
//  BaseService.swift
//  MovieApp
//
//  Created by İSMAİL AÇIKYÜREK on 13.02.2023.
//

import Foundation
import UIKit
import Alamofire


//MARK: Protocol
protocol MovieDataServiceProtokol {
    func fethAllPosts<T:Codable>(url:String,onSuccess: @escaping (T) -> Void, onFail: @escaping (String?) -> Void)
   
}

public struct MovieDataService: MovieDataServiceProtokol {
func fethAllPosts<T>(url: String, onSuccess: @escaping (T) -> Void, onFail: @escaping (String?) -> Void) where T : Decodable, T : Encodable {
    AF.request(url, method: .get).validate().responseDecodable(of:T.self) { (response) in
        guard let items =  response.value else {
            onFail(response.debugDescription)
            return
        }
        onSuccess(items)
    }
}
}
