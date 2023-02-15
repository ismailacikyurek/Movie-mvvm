//
//  Service.swift
//  MovieApp
//
//  Created by İSMAİL AÇIKYÜREK on 15.02.2023.
//

import Alamofire
import UIKit

public class DetailsService:NSObject{
    
     let service: MovieDataServiceProtokol = MovieDataService()

     func theMovieServiceSimilar(id : Int, success: @escaping (SimilarModel?) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/\(id)/similar?api_key=e1f05eb6d6888cc4a751a49802070b48&language=en-US&page=1"
        service.fethAllPosts(url: url) { (b: SimilarModel) in
           success(b)
            print(b.results.debugDescription ?? "")
        } onFail: { error in
            print(error?.description ?? "An error occured")
        }
 }

}
