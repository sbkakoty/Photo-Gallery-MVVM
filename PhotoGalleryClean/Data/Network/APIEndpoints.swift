//
//  APIEndpoints.swift
//  PhotoGalleryClean
//
//  Created by MacBook on 03/07/22.
//

import Foundation

struct APIEndpoints {
    
    static func getAlbumTitleEndpoint() -> Endpoint {

        return(Endpoint(path: "/albums", query: ""))
    }
    
    static func getAlbumPhotoEndpoint(withParam param: String) -> Endpoint {

        return(Endpoint(path: "/photos", query: param))
    }

}
