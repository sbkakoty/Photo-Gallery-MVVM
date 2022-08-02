//
//  SaveRealmUserSessionUseCase.swift
//  PhotoGalleryClean
//
//  Created by MacBook on 09/07/22.
//

import Foundation

protocol SaveRealmUserSessionUseCase {
    func execute()
}

final class SaveRealmUserSessionUseCaseImpl: SaveRealmUserSessionUseCase {

    private let realmStorageRepository: RealmStorageRepository

    init(realmStorageRepository: RealmStorageRepository) {
        self.realmStorageRepository = realmStorageRepository
    }

    func execute() {
        
        self.realmStorageRepository.saveRealmUserSession()
    }
}
