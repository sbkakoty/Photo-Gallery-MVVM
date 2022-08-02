//
//  RealmStorage.swift
//  PhotoGalleryClean
//
//  Created by MacBook on 04/07/22.
//

import Foundation
import RealmSwift

protocol RealmStorage {
    
    init()
    
    func fetchAlbumData(completion: @escaping ([SectionRealm]) -> ())
    func saveAlbumData(with albumData: [SectionRealm])
    func fetchUserSession(completion: @escaping (Int?, Date?, Bool?) -> ())
    func saveUserSession()
    func updateUserSession(with newSessionCount: Int, with elapsed: Int)
}

final class RealmStorageImpl: RealmStorage {
    
    init(){}
    
    
    func fetchAlbumData(completion: @escaping ([SectionRealm]) -> ()) {
        
        let realm = try! Realm()
        realm.beginWrite()
        let someModelResults: Results<SectionRealm> = realm.objects(SectionRealm.self)
        let someModelArray: [SectionRealm] = someModelResults.toArray(ofType: SectionRealm.self)
        try! realm.commitWrite()
        
        //dump(someModelArray)
        print("someModelArray Count: \(someModelArray.count)")
        
        completion(someModelArray)
    }
    
    func saveAlbumData(with albumData: [SectionRealm]) {
        
        let realm = try! Realm()
        realm.beginWrite()
        
        if realm.objects(SectionRealm.self).first != nil {
            
            let objectsToDelete = realm.objects(SectionRealm.self)
            realm.delete(objectsToDelete)
            realm.add(albumData)
        } else {
            
            realm.add(albumData)
        }
        try! realm.commitWrite()
    }
    
    func fetchUserSession(completion: @escaping (Int?, Date?, Bool?) -> ()) {
        
        let realm = try! Realm()
        
        if realm.objects(UserSession.self).first != nil {
            
            if let sessionData = realm.objects(UserSession.self).first {
                
                let sessionCount = Int(sessionData.sessionCount)
                let sessionDate = sessionData.sessionDate
                completion(sessionCount, sessionDate, true)
            }
        } else {
            
            completion(0, nil, false)
        }
    }
    
    func saveUserSession() {
        
        let realm = try! Realm()
        realm.beginWrite()
        let userSessionData = UserSession.create(withSessionDate: Date(), withSessionCount: 1)
        realm.add(userSessionData)
        try! realm.commitWrite()
    }
    
    func updateUserSession(with newSessionCount: Int, with elapsed: Int) {
        
        let realm = try! Realm()
        if realm.objects(UserSession.self).first != nil {
            
            if let sessionData = realm.objects(UserSession.self).first {
                
                try! realm.write {
                    
                    if elapsed == 0 { // In same day
                        
                        sessionData.sessionCount = newSessionCount
                    } else {
                        
                        sessionData.sessionDate = Date()
                        sessionData.sessionCount = 1
                    }
                }
            }
        }
    }
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }

        return array
    }
}
