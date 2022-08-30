//
//  MockAlbumTitleUseCaseTest.swift
//  PhotoGalleryCleanTests
//
//  Created by MacBook on 02/08/22.
//

import Foundation
@testable import PhotoGalleryClean

class MockAlbumTitleUseCaseTest: GetAlbumTitleUseCase {

    let album: [Album] = [
        Album(userId: 27, id: 1841, title: "vero accusamus explicabo eum rerum"),
    ]
    
    func execute(completion: @escaping ([Album]) -> Void) {
        
        print("/* Execution MockAlbumTitleUseCaseTest Started */")
        completion(album)
    }
}
