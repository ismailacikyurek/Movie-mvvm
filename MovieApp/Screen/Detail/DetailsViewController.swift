//
//  DetailsViewController.swift
//  MovieApp
//
//  Created by İSMAİL AÇIKYÜREK on 15.02.2023.
//

import UIKit
import SnapKit

class DetailsViewController: UIViewController {
    
    let lblImdb : UILabel = {
        let x = UILabel()
        x.textColor = UIColor.gray
        x.font = UIFont.systemFont(ofSize: 20.0)
        x.layer.zPosition = 1
        return x
    }()
    let pointImage : UIImageView = {
        let x = UIImageView()
        x.contentMode = .scaleToFill
        x.backgroundColor = .systemYellow
        x.layer.masksToBounds = true
        x.layer.cornerRadius = 5
        return x
    }()
    let lblDate : UILabel = {
        let x = UILabel()
        x.textColor = UIColor.black
        x.font = UIFont.systemFont(ofSize: 20.0)
        return x
    }()
    let imdbPhoto : UIImageView = {
        let x = UIImageView()
        x.image = UIImage(named: "imdb")
        x.contentMode = .scaleToFill
        return x
    }()
    let lblTitle : UILabel = {
        let x = UILabel()
        x.textColor = UIColor.black
        x.textAlignment = .left
        x.font = UIFont.boldSystemFont(ofSize: 22.0)
        return x
    }()
    let sliderCollection : UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        collectionView.isPagingEnabled = false
        viewLayout.minimumLineSpacing = 5
        viewLayout.minimumInteritemSpacing = 5
        viewLayout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = viewLayout
        collectionView.translatesAutoresizingMaskIntoConstraints = true
        return collectionView
    }()
    let lblDescription : UILabel = {
        let x = UILabel()
        x.textColor = UIColor.black
        x.font = UIFont.systemFont(ofSize: 15.0)
        x.numberOfLines = 15
        x.textAlignment = .justified
        return x
    }()
    let photoİmageView : UIImageView = {
        let x = UIImageView()
        x.contentMode = .scaleToFill
        return x
    }()
    let lblSimilarMovies : UILabel = {
        let x = UILabel()
        x.textColor = UIColor.black
        x.font = UIFont.boldSystemFont(ofSize: 20.0)
        x.textAlignment = .left
        x.text = "Benzer Filmler"
        return x
    }()
  
    var modelSearch : ResultSearch?
    var modelUpcoming : ResultUpcoming?
    var modelSimilar : SimilarModel?
    
    private var viewModel: DetailsViewModelProtocol = DetailsViewModel()
    private let movieID: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(photoİmageView)
        view.addSubview(lblDescription)
        view.addSubview(sliderCollection)
        view.addSubview(lblTitle)
        view.addSubview(lblDate)
        view.addSubview(lblImdb)
        view.addSubview(pointImage)
        view.addSubview(imdbPhoto)
        view.addSubview(lblSimilarMovies)
        
      
        viewModel.initialize()
        viewModel.setUpDelegate(self)
        setCollectionView()
       
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Film Listesi", style: .done, target: self, action: #selector(back))
        navigationItem.leftBarButtonItem?.tintColor = .black
        view.backgroundColor = .white

        if modelSearch != nil {
            modelSearchDataLoad()
            navigationItem.title = modelSearch?.title
        } else {
            modelUpcmoingDataLoad()
            navigationItem.title = modelUpcoming?.title
           
        }
        LayoutUI()
    }
    
    func  LayoutUI() {
        
        photoİmageView.snp.makeConstraints { make in
            if ScreenSize.height > 800 {
                make.top.equalTo(80)}
            else {
                make.top.equalTo(50)}
            make.width.equalToSuperview()
            make.height.equalTo(ScreenSize.height / 3)
        }
        imdbPhoto.snp.makeConstraints { make in
            make.top.equalTo(photoİmageView.snp_bottomMargin).offset(17)
            make.width.equalTo(60)
            make.height.equalTo(30)
            make.leading.equalTo(view.snp_leadingMargin).offset(5)
        }
        lblImdb.snp.makeConstraints { make in
            make.top.equalTo(photoİmageView.snp_bottomMargin).offset(17)
            make.height.equalTo(30)
            make.leading.equalTo(imdbPhoto.snp_trailingMargin).offset(10)
        }
        pointImage.snp.makeConstraints { make in
            make.top.equalTo(photoİmageView.snp_bottomMargin).offset(33)
            make.width.equalTo(7)
            make.height.equalTo(7)
            make.leading.equalTo(lblImdb.snp_trailingMargin).offset(10)
        }
        lblDate.snp.makeConstraints { make in
            make.top.equalTo(photoİmageView.snp_bottomMargin).offset(17)
            make.leading.equalTo(pointImage.snp_trailingMargin).offset(10)
            make.width.equalTo(120)
            make.height.equalTo(30)
        }
        lblTitle.snp.makeConstraints { make in
            make.top.equalTo(imdbPhoto.snp_bottomMargin).offset(15)
            make.leading.equalTo(view.snp_leadingMargin).offset(5)
            make.height.equalTo(30)
        }
        lblDescription.snp.makeConstraints { make in
            make.top.equalTo(lblTitle.snp_bottomMargin).offset(10)
            make.leading.equalTo(view.snp_leadingMargin).offset(5)
            make.trailing.equalTo(view.snp_trailingMargin).offset(-6)
        }
        lblSimilarMovies.snp.makeConstraints { make in
            make.top.equalTo(lblDescription.snp_bottomMargin).offset(20)
            make.leading.equalTo(view.snp_leadingMargin).offset(5)
        }
        sliderCollection.snp.makeConstraints { make in
            make.top.equalTo(lblSimilarMovies.snp_bottomMargin).offset(5)
            make.leading.equalTo(view.snp_leadingMargin).offset(2)
            make.trailing.equalTo(view.snp_trailingMargin).offset(-1)
            make.width.equalTo(ScreenSize.widht)
            make.height.equalTo(ScreenSize.height / 4)
            
        }
    }
    @objc func back() {
        let rootVC = MainViewController()
        let NavVC = UINavigationController(rootViewController: rootVC)
        NavVC.modalPresentationStyle = .overFullScreen
        present(NavVC, animated: true)
    }
    
    func modelUpcmoingDataLoad() {
        lblTitle.text = modelUpcoming?.title
        lblDate.text = modelUpcoming?.releaseDate
        lblDescription.text = modelUpcoming?.overview
        lblImdb.text = "\(modelUpcoming!.voteAverage!)/10"
        
        viewModel.theMovieServiceSimilar(id: (modelUpcoming?.id)!)
    
        guard let urlStr = modelUpcoming?.backdropPath else { return }
        photoİmageView.kf.setImage(with:URL(string:Constants.imageUrl + urlStr))
    }
    
    func modelSearchDataLoad() {
        lblTitle.text = modelSearch?.title
        lblDate.text = modelSearch?.releaseDate
        lblDescription.text = modelSearch?.overview
        lblImdb.text = "\(modelSearch!.voteAverage!)"
        
        viewModel.theMovieServiceSimilar(id: (modelSearch?.id)!)
        
        if let urlStr = modelSearch?.posterPath {
            photoİmageView.kf.setImage(with:URL(string:Constants.imageUrl + urlStr))
        } else {
            let urlStr = modelSearch?.backdropPath
            photoİmageView.kf.setImage(with:URL(string:Constants.imageUrl + urlStr!))
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
        if let content = modelSimilar?.results?[indexPath.row] {cell.configure(content: content)}
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: sliderCollection.frame.width / 2.7, height: sliderCollection.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
}
