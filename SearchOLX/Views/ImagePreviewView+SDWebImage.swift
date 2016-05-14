//
//  ImagePreviewView+SDWebImage.swift
//  ImagePreview
//
//  Created by Javi on 5/12/16.
//  Copyright © 2016 Globant. All rights reserved.
//

import Foundation
import SDWebImage


extension ImagePreviewView {
    
    convenience init(urlString:String) {
        self.init()
        setImageURLToPreview(urlString)
    }
    
    internal func setImageURLToPreview(urlString:String) {
        
        imageView = UIImageView()
        
        imageView!.sd_setImageWithURL(NSURL(string: urlString),
            completed: { (image: UIImage!, error: NSError!, cacheType: SDImageCacheType, imageURL: NSURL!) -> Void in
                if let _ = error {
                    
                } else {
                    if let _ = image {
                        self.setImageToPreview(image)
                    }
                }
            }
        )
        
    }
    
}

