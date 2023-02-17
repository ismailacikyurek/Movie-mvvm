//
//  SliderCollectionViewCell.swift
//  MovieApp
//
//  Created by İSMAİL AÇIKYÜREK on 14.02.2023.
//

import UIKit
import Kingfisher
import SnapKit

class SliderCollectionViewCell: UICollectionViewCell {
    static let identifier = "cell"
    let lblDescription : UILabel = {
        let x = UILabel()
//        x.frame = CGRect(x: 10, y: ScreenSize.height / 2.8, width: ScreenSize.widht - 20, height: 30)
        x.textColor = UIColor.white
        x.font = UIFont.boldSystemFont(ofSize: 12.0)
        x.numberOfLines = 3
        x.layer.zPosition = 1
        return x
    }()
    let lblTitle : UILabel = {
        let x = UILabel()
//        x.frame = CGRect(x: 10, y: ScreenSize.height / 3.2, width: ScreenSize.widht - 30, height: 30)
        x.textColor = UIColor.white
        x.font = UIFont.boldSystemFont(ofSize: 22.0)
        x.layer.zPosition = 1
        return x
    }()
    let photoImageView : UIImageView = {
        let x = UIImageView()
        x.translatesAutoresizingMaskIntoConstraints = false
//        x.frame = CGRect(x: 0, y: 0, width: ScreenSize.widht, height: ScreenSize.height / 3 + 100)
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
          contentView.addSubview(lblDescription)
          contentView.addSubview(lblTitle)
          contentView.addSubview(photoImageView)
          
          backgroundColor = UIColor.clear
          
          photoImageView.snp.makeConstraints { make in
              make.top.equalTo(0)
              make.leading.equalTo(0)
              make.height.equalTo(ScreenSize.height / 3)
              make.width.equalTo(ScreenSize.widht)
          }
          
          
          lblDescription.snp.makeConstraints { make in
              make.bottom.equalTo(photoImageView.snp_bottomMargin).offset(-60)
              make.leading.equalTo(10)
              make.height.equalTo(30)
              make.width.equalTo(ScreenSize.widht - 20)
          }
          
          lblTitle.snp.makeConstraints { make in
              make.bottom.equalTo(photoImageView.snp_bottomMargin).offset(-90)
              make.leading.equalTo(10)
              make.height.equalTo(30)
              make.width.equalTo(ScreenSize.widht - 30)
          }
      }
    
    func configure(content: Result) {
        lblTitle.text = content.originalTitle ?? ""
        lblDescription.text = content.overview ?? ""
        guard let urlStr = content.backdropPath else { return }
        let Url = "\(Constants.imageUrl)"+"\(urlStr)"
        photoImageView.kf.setImage(with:URL(string: Url))
    }
}
