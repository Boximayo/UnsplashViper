//
//  UnsplashPhotoViewController.swift
//  UnsplashViper
//
//  Created by Mayo Gonzalez ortega on 16/11/24.
//

import UIKit
import Kingfisher

class UnsplashPhotoViewController: UIViewController {
    
    var presenter: ViewToPresenterUnsplashProtocol?
    var results: [Result] = []
    
    private var currentPage: Int = 1
    private let itemsPerPage: Int = 10
    private var isLoading: Bool = false
    private var currentQuery: String = "nature"
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Buscar imágenes..."
        searchBar.delegate = self
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        view.backgroundColor = .white
        presenter?.fetchPhoto(query: currentQuery, page: currentPage, perPage: itemsPerPage) // Búsqueda inicial
    }
    
    func setupView() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
    }
}

extension UnsplashPhotoViewController: PresenterToViewUnsplashProtocol {
    func didFetchPhoto(data: UnsplashResponse) {
        DispatchQueue.main.async {
            self.results.append(contentsOf: data.results)
            self.collectionView.reloadData()
            self.isLoading = false
        }
    }
}

extension UnsplashPhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        
        let result = results[indexPath.item]
        cell.configure(with: result)
        return cell
    }
}

extension UnsplashPhotoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let itemsPerRow: CGFloat = 2
        let totalPadding = padding * (itemsPerRow + 1)
        let availableWidth = collectionView.bounds.width - totalPadding
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem + 50)
    }
}

extension UnsplashPhotoViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height - 100 {
            guard !isLoading else { return }
            isLoading = true
            currentPage += 1
            presenter?.fetchPhoto(query: currentQuery, page: currentPage, perPage: itemsPerPage)
        }
    }
}

extension UnsplashPhotoViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else { return }
        currentQuery = query
        currentPage = 1
        results.removeAll()
        collectionView.reloadData()
        presenter?.fetchPhoto(query: query, page: currentPage, perPage: itemsPerPage)
        searchBar.resignFirstResponder()
    }
}
