//
//  AlbumPhotoResponseDTO+Mapping.swift
//  PhotoGalleryClean
//
//  Created by MacBook on 04/07/22.
//

import Foundation

struct AlbumPhotoResponseDTO: Codable {
    
    let albumId : Int
    let id : Int
    let title: String
    let url: String
    let thumbnailUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case albumId
        case id
        case title
        case url
        case thumbnailUrl
    }
}

// MARK: - Mappings to Domain

extension AlbumPhotoResponseDTO {
    func toDomain() -> AlbumPhoto {
        return .init(albumId: albumId, id: id, title: title, url: url, thumbnailUrl: thumbnailUrl)
    }
}
