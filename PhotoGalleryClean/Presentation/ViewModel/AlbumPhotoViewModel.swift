//
//  AlbumPhotoViewModel.swift
//  PhotoAlbum
//
//  Created by MacBook on 29/06/22.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class AlbumPhotoViewModel : NSObject {
    
    private var dataService : DataService!
    private var photoAlbumRepository : PhotoAlbumRepository!
    private var getAlbumPhotoUseCase : GetAlbumPhotoUseCase!
    
    let sectionSubject = PublishSubject<[Section]>()
    var sectionObservable: Observable<[Section]> {
        return sectionSubject
    }
    
    var sections = [Section]()
    
    private(set) var albumPhotos : [AlbumPhoto]! {
        didSet {
            self.bindAlbumPhotoViewModelToController()
        }
    }
    
    var bindAlbumPhotoViewModelToController : (() -> ()) = {}
    
    init(albumPhotoUseCase:  GetAlbumPhotoUseCase = GetAlbumPhotoUseCaseImpl(photoAlbumRepository: PhotoAlbumRepositoryImpl(dataService: DataServiceImpl(networkService: NetworkService())))) {
        
        super.init()
        
        /*let appDIC = AppDIContainer()
        let photoGalleryDIC = appDIC.makePhotoGalleryDIContainer()
        self.dataService = photoGalleryDIC.makeDataService()
        self.photoAlbumRepository =  photoGalleryDIC.makePhotoAlbumRepository()*/
        self.getAlbumPhotoUseCase =  albumPhotoUseCase
    }
    
    func getAlbumPhotos(albums: [Album]) {
        
        var albumCount:Int32 = 1
        
        for element in albums {
            
            let albumId = element.id
            let albumTitle = element.title
            
            let query = "albumId=\(albumId)"
            
            self.getAlbumPhotoUseCase.execute(query: query, completion: { [self] (albumPhotoData: [AlbumPhoto]) in
                
                self.albumPhotos = albumPhotoData
                
                self.sections.append(Section(albumTitle: albumTitle, items: self.albumPhotos))
                
                albumCount += 1
                
                SectionCount.shareInstance.sectionCount = albumCount
                
                if albums.count == albumCount {
                    self.sectionSubject.onNext(self.sections)
                    self.sectionSubject.onCompleted()
                }
            })
        }
    }
    
    func collectionViewDataSource() -> RxCollectionViewSectionedReloadDataSource<Section> {
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<Section>(
            configureCell: { (_, collectionView, indexPath, items) in
                
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCollectionViewCell {
                
                    cell.setUpUIImageView()
                    cell.albumPhoto = items
                    
                    return cell
                } else {
                    
                    print("Error Creatining Cell")
                    return UICollectionViewCell()
                }
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
