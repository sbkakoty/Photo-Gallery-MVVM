//
//  UpdateRealmUserSessionUseCase.swift
//  PhotoGalleryClean
//
//  Created by MacBook on 09/07/22.
//

import Foundation

protocol UpdateRealmUserSessionUseCase {
    func execute(with newSessionCount: Int, with elapsed: Int)
}

final class UpdateRealmUserSessionUseCaseImpl: UpdateRealmUserSessionUseCase {

    private let realmStorageRepository: RealmStorageRepository

    init(realmStorageRepository: RealmStorageRepository) {
        self.realmStorageRepository = realmStorageRepository
    }

    func execute(with newSessionCount: Int, with elapsed: Int) {
        
        self.realmStorageRepository.updateUserSession(with: newSessionCount, with: elapsed)
    }
}
