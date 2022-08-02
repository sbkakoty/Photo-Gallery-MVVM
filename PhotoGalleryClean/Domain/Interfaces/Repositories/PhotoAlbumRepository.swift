//
//  PhotoAlbumRepository.swift
//  PhotoGalleryClean
//
//  Created by MacBook on 03/07/22.
//

import Foundation

protocol PhotoAlbumRepository {
    
    func getAlbumTitles(completion: @escaping ([AlbumResponseDTO]) -> Void)
    
    func getAlbumPhotos(query: String, completion: @escaping ([AlbumPhotoResponseDTO]) -> Void)
}
