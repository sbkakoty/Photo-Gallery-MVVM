//
//  RealmAlbumDataViewModel.swift
//  PhotoGalleryClean
//
//  Created by MacBook on 09/07/22.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class RealmAlbumDataViewModel : NSObject {
    
    private var realmStorage : RealmStorage!
    private var realmStorageRepository : RealmStorageRepository!
    private var getRealmAlbumDataUseCase : GetRealmAlbumDataUseCase!
    private var saveRealmAlbumDataUseCase : SaveRealmAlbumDataUseCase!
    
    var sections = [Section]()
    private(set) var sectionRealmData : [SectionRealm]!
    let sectionSubject = PublishSubject<[Section]>()
    var sectionObservable: Observable<[Section]> {
        return sectionSubject
    }
    
    override init() {
        super.init()
        
        let appDIC = AppDIContainer()
        let photoGalleryDIC = appDIC.makePhotoGalleryDIContainer()
        self.realmStorage = photoGalleryDIC.makeRealmStorage()
        self.realmStorageRepository =  photoGalleryDIC.makeRealmStorageRepository()
        self.getRealmAlbumDataUseCase =  photoGalleryDIC.makeGetRealmAlbumDataUseCase()
        self.saveRealmAlbumDataUseCase =  photoGalleryDIC.makeSaveRealmAlbumDataUseCase()
    }
    
    func getRealmAlbumData() {
        
        self.getRealmAlbumDataUseCase.execute(completion: { (sectionRealmData: [SectionRealm]) in
            
            if sectionRealmData.count > 0 {
                
                self.sections = [Section]()
                
                for element in sectionRealmData {
                    
                    if element.albumTitle != "" {
                        
                        var albumPhotoArray = [AlbumPhoto]()
                        let albumTitle = element.albumTitle
                        let albumPhotos = element.albumPhotos
                        
                        for albumPhoto in albumPhotos {
                            
                            let albumPhoto = AlbumPhoto(albumId: albumPhoto.albumId, id: albumPhoto.id, title: albumPhoto.title!, url: albumPhoto.url!, thumbnailUrl: albumPhoto.thumbnailUrl!)
                            albumPhotoArray.append(albumPhoto)
                            
                        }
                        self.sections.append(Section(albumTitle: albumTitle, items: albumPhotoArray))
                    }
                }
                
                self.sectionSubject.onNext(self.sections)
                self.sectionSubject.onCompleted()
            }
        })
    }
    
    func saveRealmAlbumData(with realmData: [SectionRealm]) {
        
        self.saveRealmAlbumDataUseCase.execute(with: realmData)
    }
    
    func collectionViewDataSource() -> RxCollectionViewSectionedReloadDataSource<Section> {
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<Section>(
            configureCell: { (_, collectionView, indexPath, items) in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionViewCell
                
                cell.setUpUIImageView()
                cell.albumPhoto = items
                
                return cell
            }
        )
        
        dataSource.configureSupplementaryView = { (dataSource, collectionView, kind, indexPath) in
            if kind == UICollectionView.elementKindSectionHeader {
                let section = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "albumHeader", for: indexPath) as! PhotoCollectionReusableView
                        
                section.labelAlbumTitle.text = "\(dataSource[indexPath.section].albumTitle)"
                        
                return section
            } else {
                return UICollectionReusableView()
            }
        }
        
        return dataSource
    }
}
