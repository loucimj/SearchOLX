//
//  NavigateImageViewController.swift
//  ImagePreview
//
//  Created by Javi on 4/28/16.
//  Copyright © 2016 FuzeIdea. All rights reserved.
//

import Foundation
import UIKit

extension UIResponder {
    func getParentViewController() -> UIViewController? {
        if self.nextResponder() is UIViewController {
            return self.nextResponder() as? UIViewController
        } else {
            if self.nextResponder() != nil {
                return (self.nextResponder()!).getParentViewController()
            }
            else {return nil}
        }
    }
}

extension UIImageView {
    
    
    func enableNavigationView() {
        self.userInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(showNavigationViewController))
        
        self.addGestureRecognizer(gesture)
    }
    

    func showNavigationView() {
        showNavigationViewController()
    }
    
    func showNavigationView(imageView:UIImageView) {
        if let currentViewController = UIApplication.sharedApplication().keyWindow?.rootViewController {
            let viewController = NavigateImageViewController()
            viewController.imageView = imageView
            currentViewController.presentViewController(viewController, animated: false, completion: {
            })
        }
    }
    
    @objc private func showNavigationViewController() {
        if let currentViewController = self.getParentViewController() {
            showNavigationViewControllerOnTopOf(currentViewController)
            return
        }
        
        if let currentViewController = UIApplication.sharedApplication().keyWindow?.rootViewController {
            showNavigationViewControllerOnTopOf(currentViewController)
            return
        }
    }
    private func showNavigationViewControllerOnTopOf(parentViewController:UIViewController) {
        self.userInteractionEnabled = false
        let viewController = NavigateImageViewController()
        viewController.imageView = self
        parentViewController.presentViewController(viewController, animated: false, completion: {
            self.userInteractionEnabled = true
        })
        
    }
    
}

class NavigateImageViewController: UIViewController, UIScrollViewDelegate {
    
    var imageView: UIImageView?
    var scrollView:UIScrollView?
    var cancelView:UIView?

    //MARK: - Functions
    
    @objc private func closeViewController() {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView = UIScrollView(frame: self.view.frame)
        scrollView?.maximumZoomScale = 10
        scrollView?.minimumZoomScale = 1
        scrollView?.delegate = self
        
        self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        self.view.addSubview(scrollView!)
        
        cancelView = CloseIcon(frame: CGRect(x: 15, y: 30, width: 40, height: 40))
        cancelView?.backgroundColor = UIColor.clearColor()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(closeViewController))
        cancelView?.addGestureRecognizer(gesture)
        cancelView?.userInteractionEnabled = true
     
        self.view.addSubview(cancelView!)
    }

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if let _ = imageView {
            imageView?.frame = self.view.frame
            imageView?.contentMode = .ScaleAspectFit
            scrollView?.addSubview(imageView!)
        }
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

class CloseIcon:UIView {
    override func drawRect(rect: CGRect) {
        
        //// Group
        self.backgroundColor = UIColor.clearColor()
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(17.09, 0.12))
        bezier2Path.addCurveToPoint(CGPointMake(16.5, 0.12), controlPoint1: CGPointMake(16.93, -0.04), controlPoint2: CGPointMake(16.66, -0.04))
        bezier2Path.addLineToPoint(CGPointMake(10.45, 6.18))
        bezier2Path.addCurveToPoint(CGPointMake(9.85, 6.18), controlPoint1: CGPointMake(10.28, 6.34), controlPoint2: CGPointMake(10.02, 6.34))
        bezier2Path.addLineToPoint(CGPointMake(3.82, 0.12))
        bezier2Path.addCurveToPoint(CGPointMake(3.23, 0.12), controlPoint1: CGPointMake(3.66, -0.04), controlPoint2: CGPointMake(3.39, -0.04))
        bezier2Path.addLineToPoint(CGPointMake(0.12, 3.24))
        bezier2Path.addCurveToPoint(CGPointMake(0.12, 3.84), controlPoint1: CGPointMake(-0.04, 3.41), controlPoint2: CGPointMake(-0.04, 3.67))
        bezier2Path.addLineToPoint(CGPointMake(6.15, 9.89))
        bezier2Path.addCurveToPoint(CGPointMake(6.15, 10.49), controlPoint1: CGPointMake(6.32, 10.06), controlPoint2: CGPointMake(6.32, 10.32))
        bezier2Path.addLineToPoint(CGPointMake(0.12, 16.56))
        bezier2Path.addCurveToPoint(CGPointMake(0.12, 17.16), controlPoint1: CGPointMake(-0.04, 16.73), controlPoint2: CGPointMake(-0.04, 16.99))
        bezier2Path.addLineToPoint(CGPointMake(3.23, 20.28))
        bezier2Path.addCurveToPoint(CGPointMake(3.82, 20.28), controlPoint1: CGPointMake(3.39, 20.44), controlPoint2: CGPointMake(3.66, 20.44))
        bezier2Path.addLineToPoint(CGPointMake(9.85, 14.22))
        bezier2Path.addCurveToPoint(CGPointMake(10.45, 14.22), controlPoint1: CGPointMake(10.02, 14.06), controlPoint2: CGPointMake(10.28, 14.06))
        bezier2Path.addLineToPoint(CGPointMake(16.48, 20.28))
        bezier2Path.addCurveToPoint(CGPointMake(17.07, 20.28), controlPoint1: CGPointMake(16.64, 20.44), controlPoint2: CGPointMake(16.91, 20.44))
        bezier2Path.addLineToPoint(CGPointMake(20.18, 17.16))
        bezier2Path.addCurveToPoint(CGPointMake(20.18, 16.56), controlPoint1: CGPointMake(20.34, 16.99), controlPoint2: CGPointMake(20.34, 16.73))
        bezier2Path.addLineToPoint(CGPointMake(14.15, 10.49))
        bezier2Path.addCurveToPoint(CGPointMake(14.15, 9.89), controlPoint1: CGPointMake(13.98, 10.32), controlPoint2: CGPointMake(13.98, 10.06))
        bezier2Path.addLineToPoint(CGPointMake(20.18, 3.84))
        bezier2Path.addCurveToPoint(CGPointMake(20.18, 3.24), controlPoint1: CGPointMake(20.34, 3.67), controlPoint2: CGPointMake(20.34, 3.41))
        bezier2Path.addLineToPoint(CGPointMake(17.09, 0.12))
        bezier2Path.closePath()
        bezier2Path.miterLimit = 3;

        UIColor.whiteColor().setFill()
        bezier2Path.fill()

    }
}
