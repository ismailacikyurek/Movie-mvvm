//
//  SimilarCollectionViewCell.swift
//  MovieApp
//
//  Created by İSMAİL AÇIKYÜREK on 15.02.2023.
//

import UIKit
import Kingfisher
import SnapKit


class SimilarCollectionViewCell: UICollectionViewCell {

    static let identifier = "Collectioncell"
    
    let lblTitle : UILabel = {
        let x = UILabel()
        x.textColor = UIColor.black
        x.font = UIFont.systemFont(ofSize: 14.0)
        x.numberOfLines = 1
        x.layer.zPosition = 1
        return x
    }()
    let photoimageView : UIImageView = {
        let x = UIImageView()
        x.layer.masksToBounds = true
        x.layer.cornerRadius = 8
        x.layer.borderWidth = 3
        x.layer.borderColor = CGColor(red: 120/250, green: 120/250, blue: 120/250, alpha: 1)
        return x
    }()
    
    func LayoutUI() {
        contentView.addSubview(lblTitle)
        contentView.addSubview(photoimageView)
        
        photoimageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(0)
            make.leading.equalTo(contentView.snp_leadingMargin).offset(0)
            make.width.equalTo(120)
            make.height.equalTo(ScreenSize.height / 5)
        }
        lblTitle.snp.makeConstraints { make in
            make.top.equalTo(photoimageView.snp_bottomMargin).offset(5)
            make.leading.equalTo(photoimageView.snp_leadingMargin).offset(0)
            make.width.equalTo(120)
            make.height.equalTo(30)
        }
    }
    
    func configure(content: ResultSimilar) {
        LayoutUI()
            
        lblTitle.text = content.title ?? ""
        guard let urlStr = content.posterPath else {return}
        let Url = Constants.imageUrl + urlStr
        photoimageView.kf.setImage(with:URL(string: Url))
    }
}
