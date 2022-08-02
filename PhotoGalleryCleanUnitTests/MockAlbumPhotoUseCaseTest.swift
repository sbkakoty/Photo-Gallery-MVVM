//
//  MockAlbumPhotoUseCaseTest.swift
//  PhotoGalleryCleanTests
//
//  Created by MacBook on 02/08/22.
//

import Foundation
@testable import PhotoGalleryClean

class MockAlbumPhotoUseCaseTest: GetAlbumPhotoUseCase {
    
    let albumPhotos: [AlbumPhoto] = [
            AlbumPhoto(albumId: 93, id: 4601, title: "sed beatae est", url: "https://via.placeholder.com/600/632ba9", thumbnailUrl: "https://via.placeholder.com/150/632ba9"),
            ]
    
    func execute(query: String, completion: @escaping ([AlbumPhoto]) -> Void) {
        
        completion(albumPhotos)
    }
}
