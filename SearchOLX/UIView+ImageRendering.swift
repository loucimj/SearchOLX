//
//  UIView+ImageRendering.swift
//  FoldingAnimation
//
//  Created by Javi on 9/10/15.
//  Copyright © 2015 FuzeIdea. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func flipImageVertically() -> UIImage {
        let image:UIImage = UIImage(CGImage: self.CGImage!, scale: 1.0, orientation: UIImageOrientation.DownMirrored)
        return image
    }
    
    func cropUsingRect(rect:CGRect) -> UIImage {
    
        let fixedImage = fixOrientation()
        let fixedRect = CGRect(x: rect.origin.x * self.scale, y: rect.origin.y * self.scale, width: rect.width * self.scale, height: rect.height * self.scale)
        
        let cropedImage:CGImageRef = CGImageCreateWithImageInRect(fixedImage.CGImage,fixedRect)!;
        
        let resultingImage = UIImage(CGImage: cropedImage)

        return resultingImage
        
    }
    
    func resizeImageToSize(size:CGSize) -> UIImage {
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        self.drawInRect(CGRect(origin: CGPointZero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
    
    func fixOrientation() -> UIImage {
        
        if self.imageOrientation == UIImageOrientation.Up {
            return self
        }
        
        var transform = CGAffineTransformIdentity
        
        switch self.imageOrientation {
        case .Down, .DownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height)
            transform = CGAffineTransformRotate(transform, CGFloat(M_PI));
            
        case .Left, .LeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, CGFloat(M_PI_2));
            
        case .Right, .RightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, CGFloat(-M_PI_2));
            
        case .Up, .UpMirrored:
            break
        }
        
        
        switch self.imageOrientation {
            
        case .UpMirrored, .DownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0)
            transform = CGAffineTransformScale(transform, -1, 1)
            
        case .LeftMirrored, .RightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0)
            transform = CGAffineTransformScale(transform, -1, 1);
            
        default:
            break;
        }
        
        
        
        // Now we draw the underlying CGImage into a new context, applying the transform
        // calculated above.
        let ctx = CGBitmapContextCreate(
            nil,
            Int(self.size.width),
            Int(self.size.height),
            CGImageGetBitsPerComponent(self.CGImage),
            0,
            CGImageGetColorSpace(self.CGImage),
            UInt32(CGImageGetBitmapInfo(self.CGImage).rawValue)
        )
        
        CGContextConcatCTM(ctx, transform);
        
        switch self.imageOrientation {
            
        case .Left, .LeftMirrored, .Right, .RightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0, 0, self.size.height,self.size.width), self.CGImage);
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0, 0, self.size.width,self.size.height), self.CGImage);
            break;
        }
        
        // And now we just create a new UIImage from the drawing context
        let cgimg = CGBitmapContextCreateImage(ctx)
        
        let img = UIImage(CGImage: cgimg!)
        
        //CGContextRelease(ctx);
        //CGImageRelease(cgimg);
        
        return img;
        
    }
}


extension UIView {
    
    func renderImageFromView() -> UIImage {

        UIGraphicsBeginImageContext(self.frame.size)
        self.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func renderImageFromViewWithCropRect(rect:CGRect) -> UIImage {
        let currentImage = self.renderImageFromView()
        let cropedImage:CGImageRef =
        CGImageCreateWithImageInRect(currentImage.CGImage,rect)!;
        
        return UIImage(CGImage: cropedImage)
    }
    

    func setAnchorPoint(anchorPoint: CGPoint) {
        var newPoint = CGPointMake(self.bounds.size.width * anchorPoint.x, self.bounds.size.height * anchorPoint.y)
        var oldPoint = CGPointMake(self.bounds.size.width * self.layer.anchorPoint.x, self.bounds.size.height * self.layer.anchorPoint.y)
        
        newPoint = CGPointApplyAffineTransform(newPoint, self.transform)
        oldPoint = CGPointApplyAffineTransform(oldPoint, self.transform)
        
        var position : CGPoint = self.layer.position
        
        position.x -= oldPoint.x
        position.x += newPoint.x;
        
        position.y -= oldPoint.y;
        position.y += newPoint.y;
        
        self.layer.position = position;
        self.layer.anchorPoint = anchorPoint;
    }
    
    enum AnchorPointBorders {
        case BottomBorder
        case LeftBorder
        case RightBorder
        case TopBorder
    }
    
    func setAnchorPoint(selectedBorder: AnchorPointBorders) {
        switch selectedBorder {
        case .BottomBorder:
            self.setAnchorPoint(CGPoint(x: 0.5, y: 1))
//            self.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
//            self.layer.position = CGPoint(x: self.frame.origin.x+self.frame.size.width/2, y: self.layer.position.y+self.frame.size.height/2)
            break
        case .LeftBorder:
            print("code not implemented!!!")
            abort()
            break
        case .RightBorder:
            print("code not implemented!!!")
            abort()
            break
        case .TopBorder:
            self.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
            self.layer.position = CGPoint(x: self.frame.origin.x+self.frame.size.width/2, y: self.layer.position.y)
            break
        }
    }
    
}