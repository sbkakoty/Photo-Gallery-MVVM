//
//  RealmSessionViewModel.swift
//  PhotoGalleryClean
//
//  Created by MacBook on 09/07/22.
//

import Foundation

class RealmUserSessionViewModel : NSObject {
    
    private var realmStorage : RealmStorage!
    private var realmStorageRepository : RealmStorageRepository!
    private var getRealmUserSessionUseCase : GetRealmUserSessionUseCase!
    private var saveRealmUserSessionUseCase : SaveRealmUserSessionUseCase!
    private var updateRealmUserSessionUseCase : UpdateRealmUserSessionUseCase!
    
    private(set) var sessionCount : Int!
    private(set) var sessionDate: Date!
    private(set) var sessionExist: Bool!
    
    override init() {
        super.init()
        
        let appDIC = AppDIContainer()
        let photoGalleryDIC = appDIC.makePhotoGalleryDIContainer()
        self.realmStorage = photoGalleryDIC.makeRealmStorage()
        self.realmStorageRepository =  photoGalleryDIC.makeRealmStorageRepository()
        self.getRealmUserSessionUseCase =  photoGalleryDIC.makeGetRealmUserSessionUseCase()
        self.saveRealmUserSessionUseCase =  photoGalleryDIC.makeSaveRealmUserSessionUseCase()
        self.updateRealmUserSessionUseCase =  photoGalleryDIC.makeUpdateRealmUserSessionUseCase()
        
        self.getRealmUserSession()
    }
    
    func getRealmUserSession() {
        
        self.getRealmUserSessionUseCase.execute(completion: { (sessionCount: Int?, sessionDate: Date?, sessionExist: Bool?) in
            
            self.sessionCount = sessionCount
            self.sessionDate = sessionDate
            self.sessionExist = sessionExist
        })
    }
    
    func saveRealmUserSession() {
        
        self.saveRealmUserSessionUseCase.execute()
    }
    
    func updateRealmUserSession(with newSessionCount: Int, with elapsed: Int) {
        
        self.updateRealmUserSessionUseCase.execute(with: newSessionCount, with: elapsed)
    }
}
