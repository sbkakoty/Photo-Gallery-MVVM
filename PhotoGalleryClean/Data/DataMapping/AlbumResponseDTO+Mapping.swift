//
//  AlbumResponseDTO+Mapping.swift
//  PhotoGalleryClean
//
//  Created by MacBook on 04/07/22.
//

import Foundation

struct AlbumResponseDTO: Codable {
    
    let userId : Int
    let id : Int
    let title : String
    
    private enum CodingKeys: String, CodingKey {
        case userId
        case id
        case title
    }
}

// MARK: - Mappings to Domain

extension AlbumResponseDTO {
    func toDomain() -> Album {
        return .init(userId: userId, id: id, title: title)
    }
}
