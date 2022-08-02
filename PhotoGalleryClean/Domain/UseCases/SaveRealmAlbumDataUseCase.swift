//
//  SaveRealmAlbumDataUseCase.swift
//  PhotoGalleryClean
//
//  Created by MacBook on 09/07/22.
//

import Foundation

protocol SaveRealmAlbumDataUseCase {
    func execute(with sectionRealm: [SectionRealm])
}

final class SaveRealmAlbumDataUseCaseImpl: SaveRealmAlbumDataUseCase {

    private let realmStorageRepository: RealmStorageRepository

    init(realmStorageRepository: RealmStorageRepository) {
        self.realmStorageRepository = realmStorageRepository
    }

    func execute(with sectionRealm: [SectionRealm]) {
        
        self.realmStorageRepository.saveRealmAlbumData(with: sectionRealm)
    }
}
