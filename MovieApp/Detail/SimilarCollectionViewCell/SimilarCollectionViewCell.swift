//
//  SimilarCollectionViewCell.swift
//  MovieApp
//
//  Created by İSMAİL AÇIKYÜREK on 15.02.2023.
//

import UIKit
import Kingfisher


class SimilarCollectionViewCell: UICollectionViewCell {

    static let identifier = "Collectioncell"
    
    let lblTitle : UILabel = {
        let x = UILabel()
        x.frame = CGRect(x: 10, y: 180, width: 360, height: 30)
        x.textColor = UIColor.white
        x.font = UIFont.boldSystemFont(ofSize: 12.0)
        x.numberOfLines = 3
        x.layer.zPosition = 1
        return x
    }()
    let photoimageView : UIImageView = {
        let x = UIImageView()
        x.frame = CGRect(x: 10, y: 150, width: 400, height: 30)
        x.layer.cornerRadius = 8
        x.layer.borderWidth = 3
        x.layer.borderColor = CGColor(red: 120/250, green: 120/250, blue: 120/250, alpha: 1)
        return x
    }()
    
    func configure(content: ResultSimilar) {
        contentView.addSubview(lblTitle)
        contentView.addSubview(photoimageView)
        
        lblTitle.text = content.title ?? ""
        guard let urlStr = content.posterPath else { return }
        let Url = "https://image.tmdb.org/t/p/w500"+"\(urlStr)"
        photoimageView.kf.setImage(with:URL(string: Url))
    }
    
}
