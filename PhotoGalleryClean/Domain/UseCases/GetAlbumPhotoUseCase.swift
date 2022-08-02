//
//  GetAlbumPhotoUseCase.swift
//  PhotoGalleryClean
//
//  Created by MacBook on 03/07/22.
//

import Foundation

protocol GetAlbumPhotoUseCase {
    func execute(query: String, completion: @escaping ([AlbumPhoto]) -> Void)
}

final class GetAlbumPhotoUseCaseImpl: GetAlbumPhotoUseCase {

    private let photoAlbumRepository: PhotoAlbumRepository

    init(photoAlbumRepository: PhotoAlbumRepository) {
        self.photoAlbumRepository = photoAlbumRepository
    }

    func execute(query: String, completion: @escaping ([AlbumPhoto]) -> Void) {
        return photoAlbumRepository.getAlbumPhotos(query: query, completion: { (albumPhotoData: [AlbumPhotoResponseDTO]) in
            
            completion(albumPhotoData.map { $0.toDomain() })
        })
    }
}
