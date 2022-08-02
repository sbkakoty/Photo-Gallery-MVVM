//
//  NetworkService.swift
//  PhotoGalleryClean
//
//  Created by MacBook on 03/07/22.
//

import Foundation
import Alamofire

class NetworkService : NSObject {
    
    func request(with endpoint: Endpoint, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        Alamofire.request(endpoint.url()).responseJSON(completionHandler: {
            response in
            
            DispatchQueue.main.async {
                
                completion(response.data, response.response, response.result.error)
            }
        })
    }
}
