//
//  SectionModel.swift
//  PhotoAlbum
//
//  Created by MacBook on 30/06/22.
//
import Foundation
import RxDataSources

struct Section {
    var albumTitle: String
    var items: [AlbumPhoto]
}

extension Section: SectionModelType {
    
    init(original: Section, items: [AlbumPhoto]) {
        self = original
        self.items = items
    }
}
