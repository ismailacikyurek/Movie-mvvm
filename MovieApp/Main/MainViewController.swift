//
//  ViewController.swift
//  MovieApp
//
//  Created by İSMAİL AÇIKYÜREK on 13.02.2023.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    let pageControl : UIPageControl = {
        let x = UIPageControl()
        x.numberOfPages = 20
        x.tintColor = .red
        return x
    }()
    let movieTableView : UITableView = {
        let x = UITableView()
        x.separatorStyle = .singleLine
        x.separatorInset = .zero
        return x
    }()
    let sliderCollection: UICollectionView = {
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
    let searchBar : UISearchBar = {
        let x = UISearchBar()
        x.alpha = 0.5
        x.searchTextField.backgroundColor = .white
        x.searchBarStyle = .minimal
        x.placeholder = "movie search.."
        return x
    }()
    let refreshControl : UIRefreshControl = {
        let x = UIRefreshControl()
        x.tintColor = UIColor.red
        return x
    }()
    
    let viewModel : MainViewModelProtocol = MainViewModel()
    var modelNowPlaying : NowPlayingModel?
    var modelUpcoming : UpcomingModel?
    var modelSearch : SearchModel?
    var timer : Timer?
    var currentIndex = 0
    var searchDo = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.setUpDelegate(self)
        viewModel.initialize()
        startTimer()
        searchBar.delegate = self
        reflesh()
        
        setCollectionView()
        setMovieTableView()
        
        view.addSubview(sliderCollection)
        view.addSubview(pageControl)
        view.addSubview(movieTableView)
        view.addSubview(searchBar)
        view.addSubview(refreshControl)
        
        LayoutUI()
    }
    // MARK: - LayoutUI
    func LayoutUI() {
        sliderCollection.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp_topMargin).offset(-150)
            make.width.equalToSuperview()
            make.height.equalTo(view.frame.height / 3)
        }
        movieTableView.snp.makeConstraints { make in
            make.top.equalTo(sliderCollection.snp_bottomMargin)
            make.width.equalToSuperview()
            make.bottom.equalTo(self.view.snp_bottomMargin)
        }
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(sliderCollection.snp_bottomMargin).offset(-15)
            make.width.equalToSuperview()
            make.height.equalTo(11)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(sliderCollection.snp_topMargin).offset(10)
            make.width.equalToSuperview()
        }
    }
    
    func reflesh() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.blue
        movieTableView.addSubview(refreshControl)
        
    }
    // MARK: - Timer
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(movieToIndex), userInfo: nil, repeats: true)
    }
    // MARK: - PageIndicator
    @objc func movieToIndex() {
        if currentIndex == 19 {
            currentIndex = -1
        } else {
            currentIndex += 1
            sliderCollection.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
            pageControl.currentPage = currentIndex
        }
    }
    // MARK: - Reflesh
    @objc func refresh(sender:AnyObject) {
        movieTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
}

// MARK: - Protocol
extension MainViewController : MainViewModelOutputProtocol{
    func showDataSearch(content: SearchModel) {
        modelSearch = content
        movieTableView.reloadData()
    }
    func showDataUpcoming(content: UpcomingModel) {
        modelUpcoming = content
        movieTableView.reloadData()
    }
    func showDataNowPlaying(content: NowPlayingModel) {
        modelNowPlaying = content
        sliderCollection.reloadData()
    }
}



// MARK: - CollectionView

extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func setCollectionView() {
        sliderCollection.register(SliderCollectionViewCell.self, forCellWithReuseIdentifier: SliderCollectionViewCell.identifier)
        sliderCollection.backgroundColor = .clear
        sliderCollection.showsHorizontalScrollIndicator = true
        
        sliderCollection.dataSource = self
        sliderCollection.delegate = self
        
        sliderCollection.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        modelNowPlaying?.results?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = sliderCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SliderCollectionViewCell
        
        if let content = modelNowPlaying?.results?[indexPath.row] {
            cell.configure(content: content)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: sliderCollection.frame.width, height: sliderCollection.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
}

// MARK: - TableView
extension MainViewController : UITableViewDataSource,UITableViewDelegate {
    func setMovieTableView() {
        movieTableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        movieTableView.dataSource = self
        movieTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchDo == true {
            return modelSearch?.results?.count ?? 0
        } else {
            return modelUpcoming?.results?.count ?? 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieTableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! MovieTableViewCell
        var searchFormat = ""
        if searchDo == true {
            for k in searchBar.text! {
                searchFormat.append(k)
                if searchFormat.count == 3 {
                    break
                }
            }
            movieTableView.rowHeight = 50
            if let content = modelSearch?.results?[indexPath.row] {
                cell.configureSearch(content: content)
            }
        } else {
            movieTableView.rowHeight = 153
            if let content = modelUpcoming?.results?[indexPath.row] {
                cell.configure(content: content)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cv = DetailsViewController()
        cv.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(cv, animated: true)
        
    }
}
// MARK: - SearchBar
extension MainViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchDo = true
        
        if searchDo == true {
            searchBar.alpha = 1
            DispatchQueue.main.async {
                self.viewModel.theMovieServiceSearch(search: searchText)
                self.movieTableView.reloadData()
            }
        } else {
            searchBar.alpha = 0.5
            DispatchQueue.main.async {
                self.movieTableView.reloadData()
            }
        }
        if searchText == "" {
            searchBar.alpha = 0.5
            searchDo = false
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchDo = false
        searchBar.alpha = 0.5
        searchBar.text = ""
        DispatchQueue.main.async {
            self.movieTableView.reloadData()
        }
    }
}

