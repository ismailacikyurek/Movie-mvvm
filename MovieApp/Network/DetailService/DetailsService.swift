//
//  DetailsService.swift
//  MovieApp
//
//  Created by İSMAİL AÇIKYÜREK on 16.02.2023.
//

import Alamofire
import UIKit

public class DetailsService:NSObject{

     let service: MovieDataServiceProtokol = MovieDataService()

     func theMovieServiceSimilar(id : Int, success: @escaping (SimilarModel?) -> Void) {
         let url = "\(Constants.BaseUrl)\(id)/\(Constants.similar)\(Constants.apiKey)\(Constants.Language)"
        service.fethAllPosts(url: url) { (b: SimilarModel) in
           success(b)
            print(b.results.debugDescription ?? "")
        } onFail: { error in
            print(error?.description ?? "An error occured")
        }
 }

}
