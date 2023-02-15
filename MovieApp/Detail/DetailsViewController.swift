//
//  DetailsViewController.swift
//  MovieApp
//
//  Created by İSMAİL AÇIKYÜREK on 15.02.2023.
//

import UIKit

class DetailsViewController: UIViewController {
    
    let lblImdb : UILabel = {
        let x = UILabel()
        x.frame = CGRect(x: 10, y: 180, width: 360, height: 30)
        x.textColor = UIColor.white
        x.font = UIFont.boldSystemFont(ofSize: 12.0)
        x.numberOfLines = 3
        x.layer.zPosition = 1
        return x
    }()
    
    let lblDate : UILabel = {
        let x = UILabel()
        x.frame = CGRect(x: 10, y: 180, width: 360, height: 30)
        x.textColor = UIColor.white
        x.font = UIFont.boldSystemFont(ofSize: 12.0)
        x.numberOfLines = 3
        x.layer.zPosition = 1
        return x
    }()
    
    let labelTitle : UILabel = {
        let x = UILabel()
        x.frame = CGRect(x: 10, y: 180, width: 360, height: 30)
        x.textColor = UIColor.white
        x.font = UIFont.boldSystemFont(ofSize: 12.0)
        x.numberOfLines = 3
        x.layer.zPosition = 1
        return x
    }()
    let sliderCollection : UICollectionView = {
        let x = UICollectionView()
        x.frame = CGRect(x: 10, y: 180, width: 360, height: 30)
        return x
    }()
    let txtDescription : UITextView = {
        let x = UITextView()
        x.frame = CGRect(x: 10, y: 180, width: 360, height: 30)
        x.textColor = UIColor.white
        x.font = UIFont.boldSystemFont(ofSize: 12.0)
        return x
    }()
    
    let photoİmageView : UIImageView = {
        let x = UIImageView()
        x.frame = CGRect(x: 0, y: 20, width: 360, height: 330)
        return x
    }()
    
    
    var modelSearch : ResultSearch?
    var modelUpcoming : ResultUpcoming?
    var modelSimilar : SimilarModel?
    
    let viewModel : DetailsViewModelProtocol = DetailsViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(photoİmageView)
        view.addSubview(txtDescription)
        view.addSubview(sliderCollection)
        view.addSubview(labelTitle)
        view.addSubview(lblDate)
        view.addSubview(lblImdb)
        
        viewModel.initialize()
        viewModel.setUpDelegate(self)
        setCollectionView()
        
        if modelSearch != nil {
            modelSearchDataLoad()
            navigationItem.title = modelSearch?.title
        } else {
            modelUpcmoingDataLoad()
            navigationItem.title = modelUpcoming?.title
        }
    }
    
    func modelUpcmoingDataLoad() {
        labelTitle.text = modelUpcoming?.title
        lblDate.text = modelUpcoming?.releaseDate
        txtDescription.text = modelUpcoming?.overview
        lblImdb.text = "\(modelUpcoming!.voteAverage!)"
        
        viewModel.theMovieServiceSimilar(id: (modelUpcoming?.id)!)
        
        guard let urlStr = modelUpcoming?.backdropPath else { return }
        let Url = "https://image.tmdb.org/t/p/w500"+"\(urlStr)"
        photoİmageView.kf.setImage(with:URL(string: Url))
    }
    
    func modelSearchDataLoad() {
        labelTitle.text = modelSearch?.title
        lblDate.text = modelSearch?.releaseDate
        txtDescription.text = modelSearch?.overview
        lblImdb.text = "\(modelSearch!.voteAverage!)"
        
        viewModel.theMovieServiceSimilar(id: (modelSearch?.id)!)
        
        if let urlStr = modelSearch?.posterPath {
            let Url = "https://image.tmdb.org/t/p/w500"+"\(urlStr)"
            photoİmageView.kf.setImage(with:URL(string: Url))
        } else {
            let urlStr = modelSearch?.backdropPath
            let Url = "https://image.tmdb.org/t/p/w500"+"\(urlStr)"
            photoİmageView.kf.setImage(with:URL(string: Url))
        }
    }
}

extension DetailsViewController : DetailsViewModelOutputProtocol {
    func showDataSimilar(content: SimilarModel) {
        modelSimilar = content
        self.sliderCollection.reloadData()
    }
}

extension DetailsViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func setCollectionView() {
        sliderCollection.register(SimilarCollectionViewCell.self, forCellWithReuseIdentifier: SimilarCollectionViewCell.identifier)
        sliderCollection.delegate = self
        sliderCollection.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        modelSimilar?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = sliderCollection.dequeueReusableCell(withReuseIdentifier: "Collectioncell", for: indexPath) as! SimilarCollectionViewCell
        if let content = modelSimilar?.results?[indexPath.row] {
            cell.configure(content: content)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: sliderCollection.frame.width/4, height: sliderCollection.frame.height-20)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
}
