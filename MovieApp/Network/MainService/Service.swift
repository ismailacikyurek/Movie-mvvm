//
//  Service.swift
//  MovieApp
//
//  Created by İSMAİL AÇIKYÜREK on 13.02.2023.
//

//
//  AccountService.swift
//  edakik
//
//  Created by Hızlı Geliyo on 12.10.2020.
//  Copyright © 2020 Orhun Dündar. All rights reserved.
//

import Alamofire
import UIKit

public class MainService:NSObject{
     let service: MovieDataServiceProtokol = MovieDataService()

    
    public func NowPlayingData(success: @escaping (NowPlayingModel?) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/now_playing?api_key=e1f05eb6d6888cc4a751a49802070b48&language=en-US&page=1"
        service.fethAllPosts(url: url) { (b: NowPlayingModel) in
           success(b)
        } onFail: { error in
            print(error?.description ?? "An error occured")
        }
 }
    public func UpComingData(success: @escaping (Upcoming?) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/upcoming?api_key=e1f05eb6d6888cc4a751a49802070b48&language=en-US&page=1"
        service.fethAllPosts(url: url) { (b: Upcoming) in
           success(b)
        } onFail: { error in
            print(error?.description ?? "An error occured")
            
        }
 }
    public func theMovieServiceSearch(search : String,success: @escaping (Search?) -> Void) {
        let url = "https://api.themoviedb.org/3/search/movie?api_key=e1f05eb6d6888cc4a751a49802070b48&query=\(search)"
        service.fethAllPosts(url: url) { (b: Search) in
           success(b)
        } onFail: { error in
            print(error?.description ?? "An error occured")
        }
 }

}



//
//func theMovieServiceSimilar(id : Int) {
//    let urlSimilar = "https://api.themoviedb.org/3/movie/\(id)/similar?api_key=e1f05eb6d6888cc4a751a49802070b48&language=en-US&page=1"
//    service.fethAllPosts(url: urlSimilar) { [weak self] model in
//        self?.delegate?.showDataSimilar(content: model)
//    } onFail: { error in
//        print(error?.description ?? "An error occured")
//    }
// }
//