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
        x.frame = CGRect(x: 10, y: 182, width: 110, height: 20)
        x.textColor = UIColor.black
        x.font = UIFont.systemFont(ofSize: 14.0)
        x.numberOfLines = 1
        x.layer.zPosition = 1
        return x
    }()
    let photoimageView : UIImageView = {
        let x = UIImageView()
        x.frame = CGRect(x: 10, y: 0, width: 120, height: 180)
        x.layer.masksToBounds = true
        x.layer.cornerRadius = 8
        x.layer.borderWidth = 3
        x.layer.borderColor = CGColor(red: 120/250, green: 120/250, blue: 120/250, alpha: 1)
        return x
    }()
    
    func configure(content: ResultSimilar) {
        contentView.addSubview(lblTitle)
        contentView.addSubview(photoimageView)
        
        lblTitle.text = content.title ?? ""
        guard let urlStr = content.posterPath else {return}
        let Url = Constants.imageUrl + urlStr
        photoimageView.kf.setImage(with:URL(string: Url))
    }
}
