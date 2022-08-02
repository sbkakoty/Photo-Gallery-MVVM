//
//  GetAlbumTitleUseCase.swift
//  PhotoGalleryClean
//
//  Created by MacBook on 03/07/22.
//

import Foundation

protocol GetAlbumTitleUseCase {
    func execute(completion: @escaping ([Album]) -> Void)
}

final class GetAlbumTitleUseCaseImpl: GetAlbumTitleUseCase {

    private let photoAlbumRepository: PhotoAlbumRepository

    init(photoAlbumRepository: PhotoAlbumRepository) {
        self.photoAlbumRepository = photoAlbumRepository
    }

    func execute(completion: @escaping ([Album]) -> Void) {
        return photoAlbumRepository.getAlbumTitles(completion: { (albumData: [AlbumResponseDTO]) in
            
            completion(albumData.map { $0.toDomain() })
        })
    }
}
