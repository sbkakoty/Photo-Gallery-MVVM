//
//  UserSessionRealmModel.swift
//  PhotoAlbum
//
//  Created by MacBook on 01/07/22.
//

import Foundation
import RealmSwift

class UserSession: Object {
    
    @Persisted(primaryKey: true) var sessionId = ObjectId.generate()
    @Persisted dynamic var sessionDate = Date()
    @Persisted dynamic var sessionCount = 0
    
    static func create(withSessionDate sessionDate: Date,
                       withSessionCount sessionCount: Int) -> UserSession {
        let userSession = UserSession()
        userSession.sessionDate = sessionDate
        userSession.sessionCount = sessionCount
        
        //print(albumTitle)
        
        return userSession
    }
}
