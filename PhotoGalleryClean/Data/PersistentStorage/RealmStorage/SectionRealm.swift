//
//  SectionRealmModel.swift
//  PhotoAlbum
//
//  Created by MacBook on 30/06/22.
//

import Foundation
import RealmSwift

class SectionRealm: Object {
    
    @Persisted(primaryKey: true) var sectionId = ObjectId.generate()
    @Persisted dynamic var albumTitle = ""
    @Persisted dynamic var albumPhotos = List<AlbumPhotoRealm>()
    
    static func create(withAlbumTitle albumTitle: String,
                       withAlbumPhotos albumPhotos: [AlbumPhotoRealm]) -> SectionRealm {
        let sectionRealm = SectionRealm()
        sectionRealm.albumTitle = albumTitle
        sectionRealm.albumPhotos.append(objectsIn: albumPhotos)
        
        //print(albumTitle)
        
        return sectionRealm
    }
}
