//
//  DataService.swift
//  PhotoGalleryClean
//
//  Created by MacBook on 03/07/22.
//

import Foundation

protocol DataService {
    
    init(networkService: NetworkService)
    
    func request(with endpoint: Endpoint, completion: @escaping (Data?, URLResponse?, Error?) -> ())
}

final class DataServiceImpl: DataService {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService){
        
        self.networkService = networkService
    }
    
    func request(with endpoint: Endpoint, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        
        self.networkService.request(with: endpoint) { data, response, error in
            
            completion(data, response, error)
        }
    }
}
