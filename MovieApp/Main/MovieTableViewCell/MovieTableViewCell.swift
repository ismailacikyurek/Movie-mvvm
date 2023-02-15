//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by İSMAİL AÇIKYÜREK on 14.02.2023.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    static let identifier = "tableCell"
    
    let lblTitle : UILabel = {
        let x = UILabel()
        x.textColor = UIColor.black
        x.layer.zPosition = 1
        return x
    }()
    let lblDates : UILabel = {
        let x = UILabel()
        x.frame = CGRect(x: 260, y: 110, width: 170, height: 30)
        x.textColor = UIColor.gray
        x.font = UIFont.systemFont(ofSize: 18.0)
        x.layer.zPosition = 1
        return x
    }()
    let lblDescription : UILabel = {
        let x = UILabel()
        x.frame = CGRect(x: 125, y: 40, width: 230, height: 50)
        x.textColor = UIColor.gray
        x.font = UIFont.systemFont(ofSize: 16.0)
        x.numberOfLines = 2
        return x
    }()
    let photoImageView : UIImageView = {
        let x = UIImageView()
        x.translatesAutoresizingMaskIntoConstraints = false
        x.frame = CGRect(x: 10, y: 10, width: 100, height: 130)
        x.contentMode = .scaleToFill
        x.layer.masksToBounds = true
        x.layer.cornerRadius = 13
        return x
    }()
    let rightOkImage : UIImageView = {
        let x = UIImageView()
        x.translatesAutoresizingMaskIntoConstraints = false
        x.contentMode = .scaleToFill
        x.image = UIImage(systemName: "chevron.right")
        x.tintColor = .gray
        return x
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        contentView.addSubview(lblDescription)
        contentView.addSubview(lblTitle)
        contentView.addSubview(lblDates)
        contentView.addSubview(photoImageView)
        contentView.addSubview(rightOkImage)
    }
    func configure(content: ResultUpcoming) {
        
        self.lblTitle.isHidden = false
        self.lblDates.isHidden = false
        self.lblDescription.isHidden = false
        self.photoImageView.isHidden = false
        
        lblTitle.font = UIFont.boldSystemFont(ofSize: 22.0)
        lblTitle.frame = CGRect(x: 125, y: 10, width: 260, height: 30)
        rightOkImage.frame = CGRect(x: 350, y: 70, width: 15, height: 15)
        lblTitle.text = content.title
        lblDescription.text =  content.overview
        lblDates.text = content.releaseDate
        guard let urlStr = content.posterPath else { return }
        let Url = "https://image.tmdb.org/t/p/w500"+"\(urlStr)"
        photoImageView.kf.setImage(with:URL(string: Url))
    }
    
    func configureSearch(content: ResultSearch) {
        self.lblTitle.isHidden = false
        self.lblDates.isHidden = true
        self.lblDescription.isHidden = true
        self.photoImageView.isHidden = true
        lblTitle.text = content.title ?? ""
        lblTitle.font = UIFont.systemFont(ofSize: 22.0)
        lblTitle.frame = CGRect(x: 10, y: 10, width: 350, height: 30)
        rightOkImage.frame = CGRect(x: 350, y: 20, width: 15, height: 15)
    }

}

 
