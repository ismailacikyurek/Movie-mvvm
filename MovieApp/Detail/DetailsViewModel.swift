//
//  DetailsViewModel.swift
//  MovieApp
//
//  Created by İSMAİL AÇIKYÜREK on 15.02.2023.
//

import Foundation
//
//  DetaitsViewController.swift
//  theMovieDb
//
//  Created by İSMAİL AÇIKYÜREK on 31.07.2022.
//

import UIKit
import Kingfisher




//
//  DetailsViewModel.swift
//  MovieMVVM
//
//  Created by İSMAİL AÇIKYÜREK on 2.08.2022.
//


import UIKit
import Alamofire
import Kingfisher

protocol DetailsViewModelProtocol {
    func initialize()
    func setUpDelegate(_ viewController: DetailsViewController)
    func theMovieServiceSimilar(id : Int)
}

protocol DetailsViewModelOutputProtocol {
    func showDataSimilar(content: SimilarModel)
}

class DetailsViewModel:NSObject {
    private let detailsService = DetailsService()
    var delegate: DetailsViewModelOutputProtocol?

    func initialize(){}
    
   func theMovieServiceSimilar(id : Int) {
       detailsService.theMovieServiceSimilar(id: id) { reponse in
           self.delegate?.showDataSimilar(content: reponse!)
       }
    }
}

extension DetailsViewModel: DetailsViewModelProtocol {
    func setUpDelegate(_ viewController: DetailsViewController) {
        delegate = viewController as! DetailsViewModelOutputProtocol
    }
}

