//
//  GetRealmUserSessionUseCase.swift
//  PhotoGalleryClean
//
//  Created by MacBook on 09/07/22.
//

import Foundation

protocol GetRealmUserSessionUseCase {
    func execute(completion: @escaping (Int?, Date?, Bool?) -> Void)
}

final class GetRealmUserSessionUseCaseImpl: GetRealmUserSessionUseCase {

    private let realmStorageRepository: RealmStorageRepository

    init(realmStorageRepository: RealmStorageRepository) {
        self.realmStorageRepository = realmStorageRepository
    }

    func execute(completion: @escaping (Int?, Date?, Bool?) -> Void) {
        return realmStorageRepository.fetchRealmUserSession(completion: { (sessionCount, sessionDate, sessionExist) in
            
            completion(sessionCount, sessionDate, sessionExist)
        })
    }
}
