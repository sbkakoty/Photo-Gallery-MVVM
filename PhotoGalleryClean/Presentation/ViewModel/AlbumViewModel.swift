//
//  AlbumViewModel.swift
//  PhotoGalleryClean
//
//  Created by MacBook on 02/07/22.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class AlbumViewModel : NSObject {
    
    private var dataService : DataService!
    private var photoAlbumRepository : PhotoAlbumRepository!
    private var getAlbumTitleUseCase : GetAlbumTitleUseCase!
    
    private(set) var albums : [Album]! {
        didSet {
            self.bindAlbumViewModelToController()
        }
    }
    
    var bindAlbumViewModelToController : (() -> ()) = {}
    
    init(albumTitleUseCase:  GetAlbumTitleUseCase = GetAlbumTitleUseCaseImpl(photoAlbumRepository: PhotoAlbumRepositoryImpl(dataService: DataServiceImpl(networkService: NetworkService())))) {
        
        super.init()
        
        self.getAlbumTitleUseCase =  albumTitleUseCase
        
        getAlbumTitle()
    }
    
    func getAlbumTitle() {
        
        self.getAlbumTitleUseCase.execute(completion: { (albumData: [Album]) in
            
            self.albums = albumData
        })
    }
}
