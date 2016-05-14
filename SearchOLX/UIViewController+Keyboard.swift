//
//  UIViewController+Keyboard.swift
//
//  Created by Javi on 4/23/16.
//  Copyright © 2016 QeepTouch. All rights reserved.
//

import UIKit

private var scrollViewKey : UInt8 = 0
private var dismissTapGesture:UITapGestureRecognizer?
private var offsetHeight: CGFloat = 0
private let padding:CGFloat = 40

extension UIView {
    public func getCurrentFocusedTextField() -> UIView? {
        for view in self.subviews {
            if view.isFirstResponder() {
                return view
            }
            if let focusedView = view.getCurrentFocusedTextField() {
                return focusedView
            }
        }
        return nil
    }
    
}
extension UIViewController {
    

    public func setupKeyboardNotifcationListener() {
        
        dismissTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dimsissKeyboard) )
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UIViewController.keyboardDidShow(_:)), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UIViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    public func dimsissKeyboard() {
        self.view.endEditing(true)
    }
    
    public func removeKeyboardNotificationListeners() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    func keyboardDidShow(notification: NSNotification) {
        let userInfo = notification.userInfo as! Dictionary<String, AnyObject>
        let animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSTimeInterval
        let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue
        
        
        if let _ = keyboardFrame {
            var offsetToScroll:CGFloat = 0
            if let currentField = self.view.getCurrentFocusedTextField() {
                let frame = currentField.convertRect(currentField.bounds, toView: self.view)
                
                let probablePosition = frame.origin.y + frame.height + padding
                if probablePosition > keyboardFrame?.origin.y {
                    offsetToScroll = probablePosition - (keyboardFrame?.origin.y)!
                }
            }
            
            let options = UIViewAnimationOptions.BeginFromCurrentState
            UIView.animateWithDuration(animationDuration, delay: 0, options:options, animations: { () -> Void in
                
                self.view.frame.origin = CGPoint(x: 0, y: offsetToScroll * -1)
                
            }) { (complete) -> Void in
                
                if let _ = dismissTapGesture {
                    self.view.addGestureRecognizer(dismissTapGesture!)
                }
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        let userInfo = notification.userInfo as! Dictionary<String, AnyObject>
        let animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSTimeInterval
        let options = UIViewAnimationOptions.BeginFromCurrentState
        UIView.animateWithDuration(animationDuration, delay: 0, options:options, animations: { () -> Void in
            
            self.view.frame.origin = CGPoint(x: 0, y: 0)
            
        }) { (complete) -> Void in
            if let _ = dismissTapGesture {
                self.view.removeGestureRecognizer(dismissTapGesture!)
            }
        }
    }

}
