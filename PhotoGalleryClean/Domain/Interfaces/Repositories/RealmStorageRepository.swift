//
//  RealmStorageRepository.swift
//  PhotoGalleryClean
//
//  Created by MacBook on 08/07/22.
//

import Foundation

protocol RealmStorageRepository {
    
    func fetchRealmAlbumData(completion: @escaping ([SectionRealm]) -> Void)
    
    func saveRealmAlbumData(with albumData: [SectionRealm])
    
    func fetchRealmUserSession(completion: @escaping (Int?, Date?, Bool?) -> ())
    
    func saveRealmUserSession()
    
    func updateUserSession(with newSessionCount: Int, with elapsed: Int)
}
