//
//  AlbumPhoto.swift
//  PhotoAlbum
//
//  Created by MacBook on 30/06/22.
//

import Foundation

struct AlbumPhoto: Equatable {
    
    let albumId : Int
    let id : Int
    let title: String
    let url: String
    let thumbnailUrl: String
    
    /*convenience init(albumId: Int, id: Int, title: String, url: String, thumbnailUrl: String) {
        self.init()
        self.albumId = albumId
        self.id = id
        self.title = title
        self.url = url
        self.thumbnailUrl = thumbnailUrl
    }*/
}
