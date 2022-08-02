//
//  RealmStorageRepositoryImpl.swift
//  PhotoGalleryClean
//
//  Created by MacBook on 08/07/22.
//

import Foundation

final class RealmStorageRepositoryImpl {

    private let realmStorage: RealmStorage

    init(realmStorage: RealmStorage) {
        self.realmStorage = realmStorage
    }
}

extension RealmStorageRepositoryImpl: RealmStorageRepository {
    
    func fetchRealmAlbumData(completion: @escaping ([SectionRealm]) -> Void) {
        
        self.realmStorage.fetchAlbumData() { albumData in
            completion(albumData)
        }
    }
    
    func saveRealmAlbumData(with albumData: [SectionRealm]) {
        
        self.realmStorage.saveAlbumData(with: albumData)
    }
    
    func fetchRealmUserSession(completion: @escaping (Int?, Date?, Bool?) -> Void) {
        
        self.realmStorage.fetchUserSession() { sessionCount, sessionDate, sessionExist in
            
            completion(sessionCount, sessionDate, sessionExist)
        }
    }
    
    func saveRealmUserSession() {
        
        self.realmStorage.saveUserSession()
    }
    
    func updateUserSession(with newSessionCount: Int, with elapsed: Int){
        
        self.realmStorage.updateUserSession(with: newSessionCount, with: elapsed)
    }
}
