//
//  UnsplashPhotoPresenter.swift
//  UnsplashViper
//
//  Created by Mayo Gonzalez ortega on 16/11/24.
//

import UIKit

class UnsplashPhotoPresenter: ViewToPresenterUnsplashProtocol {

    weak var view: PresenterToViewUnsplashProtocol?
    var interactor: PresenterToInteractorUnsplashProtocol?
    var router: PresenterToRouterUnsplashProtocol?
    
    func fetchPhoto(query: String, page: Int, perPage: Int) {
        interactor?.fetchPhoto(query: query, page: page, perPage: perPage)
    }
}

extension UnsplashPhotoPresenter: InteractorToPresenterUnsplashProtocol {
    func didFetchPhoto(data: UnsplashResponse) {
        view?.didFetchPhoto(data: data)
    }
}
