//
//  UnsplashPhotoRouter.swift
//  UnsplashViper
//
//  Created by Mayo Gonzalez ortega on 16/11/24.
//

import UIKit

class UnsplashPhotoRouter {
    static func createModule() -> UIViewController {
        let viewController = UnsplashPhotoViewController()
        let interactor = UnsplashPhotoInteractor()
        let router = UnsplashPhotoRouter()
        let presenter = UnsplashPhotoPresenter()
        
        viewController.presenter = presenter
        presenter.router = router
        presenter.view = viewController
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return viewController
    }
}

extension UnsplashPhotoRouter: PresenterToRouterUnsplashProtocol { }
