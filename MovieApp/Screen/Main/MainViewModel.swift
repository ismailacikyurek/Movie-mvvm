//
//  MainViewModel.swift
//  MovieApp
//
//  Created by İSMAİL AÇIKYÜREK on 14.02.2023.
//

import UIKit

protocol MainViewModelProtocol {
    func initialize()
    func setUpDelegate(_ viewController: MainViewController)
    func theMovieServiceSearch(search : String)
}

protocol MainViewModelOutputProtocol {
    func showDataNowPlaying(content: NowPlayingModel)
    func showDataUpcoming(content: UpcomingModel)
    func showDataSearch(content: SearchModel)
 
}

class MainViewModel:NSObject {
  
    private let mainService = MainService()
    var delegate: MainViewModelOutputProtocol?

    func initialize() {
        showDataNowPlaying()
        showDataUpComing()
    }
    
     func showDataNowPlaying() {
         mainService.NowPlayingData { response in
             self.delegate?.showDataNowPlaying(content: response!)
         }
     }
    func showDataUpComing() {
        mainService.UpComingData { response in
            self.delegate?.showDataUpcoming(content: response!)
        }
    }
    func theMovieServiceSearch(search : String) {
        mainService.theMovieServiceSearch(search: search) { response in
            self.delegate?.showDataSearch(content: response!)
        }
    }
}

extension MainViewModel: MainViewModelProtocol {
    func setUpDelegate(_ viewController: MainViewController) {
        delegate = viewController as! MainViewModelOutputProtocol
    }
    
}

