//
//  AppDIContainer.swift
//  PhotoGalleryClean
//
//  Created by MacBook on 04/07/22.
//

import Foundation

final class AppDIContainer {
    
    // MARK: - DIContainers of scenes
    func makePhotoGalleryDIContainer() -> PhotoGalleryDIContainer {
        
        return PhotoGalleryDIContainer()
    }
}
