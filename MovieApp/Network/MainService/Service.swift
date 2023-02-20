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
        service.fethAllPosts(url: Constants.BaseUrl + Constants.nowPlaying + Constants.apiKey + Constants.Language) { (b: NowPlayingModel) in
            success(b)
            print(b.results.debugDescription ?? "")
        } onFail: { error in
            print(error?.description ?? "An error occured")
        }
    }
    public func UpComingData(success: @escaping (UpcomingModel?) -> Void) {
        service.fethAllPosts(url: Constants.BaseUrl + Constants.upcoming + Constants.apiKey + Constants.Language) { (b: UpcomingModel) in
            success(b)
            print(b.results.debugDescription ?? "")
        } onFail: { error in
            print(error?.description ?? "An error occured")
            
        }
    }
    public func theMovieServiceSearch(search : String,success: @escaping (SearchModel?) -> Void) {
        service.fethAllPosts(url: Constants.SearchUrl + Constants.apiKey + "&query=\(search)" ) { (b: SearchModel) in
            success(b)
            print(b.results.debugDescription ?? "")
        } onFail: { error in
            print(error?.description ?? "An error occured")
        }
    }
    
}



