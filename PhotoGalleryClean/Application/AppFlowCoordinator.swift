//
//  AppFlowCoordinator.swift
//  PhotoGalleryClean
//
//  Created by MacBook on 04/07/22.
//

import UIKit

final class AppFlowCoordinator {

    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        // In App Flow we can check if user needs to login, if yes we would run login flow
        
        let vc = AlbumViewController()

        navigationController.pushViewController(vc, animated: false)
    }
}
