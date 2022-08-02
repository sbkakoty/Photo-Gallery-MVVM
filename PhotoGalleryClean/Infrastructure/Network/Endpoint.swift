//
//  Endpoint.swift
//  PhotoGalleryClean
//
//  Created by MacBook on 03/07/22.
//

import Foundation

final class Endpoint {
    let path: String
    let query: String
    
    init(path: String, query: String) {
        self.path = path
        self.query = query
    }
    
    func url() -> URL {
        
        let appConfig = AppConfig()
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = appConfig.apiBaseURL
        components.path = self.path
        if self.query.count > 0 {
            components.query = self.query
        }

        return components.url!
    }
}
