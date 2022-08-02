//
//  GetRealmAlbumDataUseCase.swift
//  PhotoGalleryClean
//
//  Created by MacBook on 09/07/22.
//

import Foundation

protocol GetRealmAlbumDataUseCase {
    func execute(completion: @escaping ([SectionRealm]) -> Void)
}

final class GetRealmAlbumDataUseCaseImpl: GetRealmAlbumDataUseCase {

    private let realmStorageRepository: RealmStorageRepository

    init(realmStorageRepository: RealmStorageRepository) {
        self.realmStorageRepository = realmStorageRepository
    }

    func execute(completion: @escaping ([SectionRealm]) -> Void) {
        return realmStorageRepository.fetchRealmAlbumData(completion: { (sectionRealmData: [SectionRealm]) in
            
            completion(sectionRealmData)
        })
    }
}
