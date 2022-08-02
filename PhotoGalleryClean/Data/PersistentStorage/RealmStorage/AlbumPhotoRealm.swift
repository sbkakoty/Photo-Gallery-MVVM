//
//  AlbumPhotos.swift
//  PhotoAlbum
//
//  Created by MacBook on 29/06/22.
//

import Foundation
import RealmSwift

class AlbumPhotoRealm: Object {
    
    @Persisted(primaryKey: true) var albumPhotoId = ObjectId.generate()
    @Persisted dynamic var albumId = 0
    @Persisted dynamic var id = 0
    @Persisted dynamic var title: String?
    @Persisted dynamic var url: String?
    @Persisted dynamic var thumbnailUrl: String?
    
    static func create(withAlbumId albumId: Int, withId id: Int, withTitle title: String, withUrl url: String, withThumbnailUrl thumbnailUrl: String) -> AlbumPhotoRealm {
        
        let albumPhoto = AlbumPhotoRealm()
        albumPhoto.albumId = albumId
        albumPhoto.id = id
        albumPhoto.title = title
        albumPhoto.url = url
        albumPhoto.thumbnailUrl = thumbnailUrl
        
        return albumPhoto
    }
}
