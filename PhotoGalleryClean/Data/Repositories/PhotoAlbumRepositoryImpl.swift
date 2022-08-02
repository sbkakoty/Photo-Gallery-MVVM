//
//  PhotoAlbumRepositoryImpl.swift
//  PhotoGalleryClean
//
//  Created by MacBook on 03/07/22.
//

import Foundation

final class PhotoAlbumRepositoryImpl {

    private let dataService: DataService

    init(dataService: DataService) {
        self.dataService = dataService
    }
}

extension PhotoAlbumRepositoryImpl: PhotoAlbumRepository {
    
    func getAlbumTitles(completion: @escaping ([AlbumResponseDTO]) -> Void) {
        
        let endpoint = APIEndpoints.getAlbumTitleEndpoint()
        
        self.dataService.request(with: endpoint) { data, response, error in
            if error != nil {
                
                print(error!.localizedDescription)
            }
            guard let data = data else { return }
            //Implement JSON decoding and parsing
            do {
                let albumData = try JSONDecoder().decode([AlbumResponseDTO].self, from: data)
                
                completion(albumData)
                
            } catch let jsonError {
                
                print(jsonError)
            }
        }
    }
    
    func getAlbumPhotos(query: String, completion: @escaping ([AlbumPhotoResponseDTO]) -> Void) {
        
        let endpoint = APIEndpoints.getAlbumPhotoEndpoint(withParam: query)
        
        self.dataService.request(with: endpoint) { data, response, error in
            if error != nil {
                
                print(error!.localizedDescription)
            }
            guard let data = data else { return }
            //Implement JSON decoding and parsing
            do {
                let albumPhotoData = try JSONDecoder().decode([AlbumPhotoResponseDTO].self, from: data)
                
                completion(albumPhotoData)
                
            } catch let jsonError {
                
                print(jsonError)
            }
        }
    }
}
