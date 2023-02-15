//
//  Service.swift
//  MovieApp
//
//  Created by İSMAİL AÇIKYÜREK on 13.02.2023.
//



import Alamofire
import UIKit

public class MainService:NSObject{
    let service: MovieDataServiceProtokol = MovieDataService()
    
    public func NowPlayingData(success: @escaping (NowPlayingModel?) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/now_playing?api_key=e1f05eb6d6888cc4a751a49802070b48&language=en-US&page=1"
        service.fethAllPosts(url: url) { (b: NowPlayingModel) in
            success(b)
            print(b.results.debugDescription ?? "")
        } onFail: { error in
            print(error?.description ?? "An error occured")
        }
    }
    public func UpComingData(success: @escaping (UpcomingModel?) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/upcoming?api_key=e1f05eb6d6888cc4a751a49802070b48&language=en-US&page=1"
        service.fethAllPosts(url: url) { (b: UpcomingModel) in
            success(b)
            print(b.results.debugDescription ?? "")
        } onFail: { error in
            print(error?.description ?? "An error occured")
            
        }
    }
    public func theMovieServiceSearch(search : String,success: @escaping (SearchModel?) -> Void) {
        let url = "https://api.themoviedb.org/3/search/movie?api_key=e1f05eb6d6888cc4a751a49802070b48&query=\(search)"
        service.fethAllPosts(url: url) { (b: SearchModel) in
            success(b)
            print(b.results.debugDescription ?? "")
        } onFail: { error in
            print(error?.description ?? "An error occured")
        }
    }
    
}


