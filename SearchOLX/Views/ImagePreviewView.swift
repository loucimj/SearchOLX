//
//  ImagePreviewView.swift
//  ImagePreview
//
//  Created by Javi on 4/28/16.
//  Copyright © 2016 FuzeIdea. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class ImagePreviewView: UIView {
    
    var image:UIImage?
    let downloader = ImageDownloader()
    var imageView:UIImageView?
    
    convenience init(image:UIImage) {
        self.dynamicType.init()
        self.init()
        setImageToPreview(image)
    }
    convenience init(urlString:String) {
        self.dynamicType.init()
        self.init()
        setImageURLToPreview(urlString)
    }
    
    internal func setImageURLToPreview(urlString:String) {
        let URLRequest = NSURLRequest(URL: NSURL(string: urlString)!)
        
        dispatch_async(dispatch_get_main_queue(), {
            if let _ = self.imageView {
                self.imageView?.removeFromSuperview()
            }
        })
        self.downloader.downloadImage(URLRequest: URLRequest) { response in
            if let image = response.result.value {
                self.setImageToPreview(image)
            }
        }
        
    }
    
    
    internal func setImageToPreview(image:UIImage) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {

            self.image = image
        
            var imageWidth:CGFloat = 0
            var imageHeight:CGFloat = 0
            
            var cropRect:CGRect = CGRect()
            
            if self.frame.size.width > self.frame.size.height {
                imageWidth = self.frame.size.width
                imageHeight = (imageWidth / image.size.width) * image.size.height
                
                cropRect = CGRect(origin: CGPoint(x: 0,y: (imageHeight - self.frame.size.height) / 2 ), size: CGSize(width: imageWidth, height: self.frame.size.height))
                
            } else {
                
                imageHeight = self.frame.size.height
                imageWidth = (imageHeight / image.size.height) * image.size.width
                
                cropRect = CGRect(origin: CGPoint(x: 0,y: (imageWidth - self.frame.size.width) / 2 ), size: CGSize(width: self.frame.width, height: imageHeight))
            }
            
            let scaledImage = image.resizeImageToSize(CGSize(width: imageWidth, height: imageHeight))
            
            let croppedImage = scaledImage.cropUsingRect(cropRect)
            self.imageView = UIImageView()
            self.imageView?.image = croppedImage
            self.imageView?.frame = self.bounds

            let gesture = UITapGestureRecognizer(target: self, action: #selector(self.openImageNavigationView))
            gesture.cancelsTouchesInView = false
            self.imageView?.userInteractionEnabled = true
            self.imageView?.addGestureRecognizer(gesture)
            
            dispatch_async(dispatch_get_main_queue(), {
                self.addSubview(self.imageView!)
            })
        
        })
        
    }
    
    @objc private func openImageNavigationView() {
        if let _ = image {
            let imageView = UIImageView(image: image)
            imageView.showNavigationView()
        }
    }
}

