//
//  PhotoCollectionViewCell.swift
//  PhotoAlbum
//
//  Created by MacBook on 28/06/22.
//

import UIKit
import Alamofire

class PhotoCollectionViewCell: UICollectionViewCell {
    
    var albumPhoto: AlbumPhoto? {
        didSet {
            
            if let imageURL = albumPhoto?.thumbnailUrl {
                
                Alamofire.request(imageURL, method: .get).response { (responseData) in
                    if let data = responseData.data {
                        DispatchQueue.main.async {
                
                            self.photoImageView.image = UIImage(data: data)
                        }
                    } else {
                        
                        print("Error")
                    }
                }
            }
        }
    }

    let photoImageView: UIImageView = {
        
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 7
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.tag = 112
        return iv
    }()
    
    func setUpUIImageView() {
        
        addSubview(photoImageView)
        photoImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        photoImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        photoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
    }
    
    override func prepareForReuse()
    {
        
        super.prepareForReuse()
        
        if let viewWithTag = self.viewWithTag(112) {
            
            //print("prepareForReuse PhotoCell")
            viewWithTag.removeFromSuperview()
            self.setUpUIImageView()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
