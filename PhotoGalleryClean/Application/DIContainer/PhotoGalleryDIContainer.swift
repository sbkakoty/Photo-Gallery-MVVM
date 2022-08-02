//
//  PhotoGalleryDIContainer.swift
//  PhotoGalleryClean
//
//  Created by MacBook on 04/07/22.
//

import Foundation

final class PhotoGalleryDIContainer {
    
    func makeDataService() -> DataService {
        return DataServiceImpl(networkService: NetworkService())
    }
    
    func makePhotoAlbumRepository() -> PhotoAlbumRepository {
        return PhotoAlbumRepositoryImpl(dataService: makeDataService())
    }
    
    func makeGetAlbumTitleUseCase() -> GetAlbumTitleUseCase {
        return GetAlbumTitleUseCaseImpl(photoAlbumRepository: makePhotoAlbumRepository())
    }
    
    func makeGetAlbumPhotoUseCase() -> GetAlbumPhotoUseCase {
        return GetAlbumPhotoUseCaseImpl(photoAlbumRepository: makePhotoAlbumRepository())
    }
    
    func makeRealmStorage() -> RealmStorage {
        return RealmStorageImpl()
    }
    
    func makeRealmStorageRepository() -> RealmStorageRepository {
        return RealmStorageRepositoryImpl(realmStorage: makeRealmStorage())
    }
    
    func makeGetRealmAlbumDataUseCase() -> GetRealmAlbumDataUseCase {
        return GetRealmAlbumDataUseCaseImpl(realmStorageRepository: makeRealmStorageRepository())
    }
    
    func makeSaveRealmAlbumDataUseCase() -> SaveRealmAlbumDataUseCase {
        return SaveRealmAlbumDataUseCaseImpl(realmStorageRepository: makeRealmStorageRepository())
    }
    
    func makeGetRealmUserSessionUseCase() -> GetRealmUserSessionUseCase {
        return GetRealmUserSessionUseCaseImpl(realmStorageRepository: makeRealmStorageRepository())
    }
    
    func makeSaveRealmUserSessionUseCase() -> SaveRealmUserSessionUseCase {
        return SaveRealmUserSessionUseCaseImpl(realmStorageRepository: makeRealmStorageRepository())
    }
    
    func makeUpdateRealmUserSessionUseCase() -> UpdateRealmUserSessionUseCase {
        return UpdateRealmUserSessionUseCaseImpl(realmStorageRepository: makeRealmStorageRepository())
    }
}
