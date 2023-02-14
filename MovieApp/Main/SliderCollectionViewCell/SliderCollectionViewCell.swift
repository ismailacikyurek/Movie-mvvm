//
//  SliderCollectionViewCell.swift
//  MovieApp
//
//  Created by İSMAİL AÇIKYÜREK on 14.02.2023.
//

import UIKit
import Kingfisher

class SliderCollectionViewCell: UICollectionViewCell {
    static let identifier = "cell"
    let lblDescription : UILabel = {
        let x = UILabel()
        x.frame = CGRect(x: 10, y: 180, width: 360, height: 30)
        x.textColor = UIColor.white
        x.font = UIFont.boldSystemFont(ofSize: 12.0)
        x.numberOfLines = 3
        x.layer.zPosition = 1
        return x
    }()
    let lblTitle : UILabel = {
        let x = UILabel()
        x.frame = CGRect(x: 10, y: 150, width: 400, height: 30)
        x.textColor = UIColor.white
        x.font = UIFont.boldSystemFont(ofSize: 22.0)
        x.layer.zPosition = 1
        return x
    }()
    let photoImageView : UIImageView = {
        let x = UIImageView()
        x.translatesAutoresizingMaskIntoConstraints = false
        x.frame = CGRect(x: 0, y: 0, width: 400, height: 250)
        x.contentMode = .scaleToFill
        return x
    }()
    override init(frame: CGRect) {
          super.init(frame: frame)
          setupViews()
      }
      required init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
      func setupViews(){
          backgroundColor = UIColor.clear
      }
    func configure(content: Result) {
        contentView.addSubview(lblDescription)
        contentView.addSubview(lblTitle)
        contentView.addSubview(photoImageView)
        
        lblTitle.text = content.originalTitle ?? "A"
        lblDescription.text = content.overview ?? ""
        guard let urlStr = content.backdropPath else { return }
        let Url = "https://image.tmdb.org/t/p/w500"+"\(urlStr)"
        photoImageView.kf.setImage(with:URL(string: Url))
    }
}
