//
//  UnsplashPhotoProtocols.swift
//  UnsplashViper
//
//  Created by Mayo Gonzalez ortega on 16/11/24.
//

import UIKit

protocol PresenterToViewUnsplashProtocol: AnyObject {
    func didFetchPhoto(data: UnsplashResponse)
}

protocol ViewToPresenterUnsplashProtocol: AnyObject {
    var view: PresenterToViewUnsplashProtocol? { get set }
    var interactor: PresenterToInteractorUnsplashProtocol? { get set }
    var router: PresenterToRouterUnsplashProtocol? { get set }
    func fetchPhoto(query: String, page: Int, perPage: Int)
}

protocol PresenterToInteractorUnsplashProtocol: AnyObject {
    var presenter: InteractorToPresenterUnsplashProtocol? { get set }
    func fetchPhoto(query: String, page: Int, perPage: Int)
}

protocol InteractorToPresenterUnsplashProtocol: AnyObject {
    func didFetchPhoto(data: UnsplashResponse)
}

protocol PresenterToRouterUnsplashProtocol: AnyObject { }
