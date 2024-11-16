//
//  UnsplashPhotoInteractor.swift
//  UnsplashViper
//
//  Created by Mayo Gonzalez ortega on 16/11/24.
//

import UIKit

class UnsplashPhotoInteractor: PresenterToInteractorUnsplashProtocol {
    
    weak var presenter: InteractorToPresenterUnsplashProtocol?
    
    func fetchPhoto(query: String, page: Int, perPage: Int) {
        guard let url = URL(string: "https://api.unsplash.com/search/photos?page=1&query=\(query)&page=\(page)&per_page=\(perPage)&client_id=Q2CRSRDrWNrjGpd2PLfhFhmT77ShAx0MiP_GYx7HL58") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(UnsplashResponse.self, from: data)
                self?.presenter?.didFetchPhoto(data: response)
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
}
