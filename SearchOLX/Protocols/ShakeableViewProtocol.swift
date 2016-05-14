//
//  ShakeableViewProtocol.swift
//  StarMeUp
//
//  Created by Javier Loucim
//  Copyright © 2016 FuzeIdea. All rights reserved.
//

import Foundation
import AudioToolbox
import UIKit

/**
 Defines two required functions for the Shakeable View Protocol, shake() and shakeAndVibrate()
 */
protocol ShakeableViewProtocol {
    func shake()
    func shakeAndVibrate()
}


/**
 Extends the ShakeableViewProtocol providing default implementation for its functions. The extension is aplicable where self:UIView
 */
extension ShakeableViewProtocol where Self: UIView {
    
    // Shakes a UIView by adding an animation on its X axis
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.addAnimation(animation, forKey: "shake")
    }
    
    // In addition to shake, makes the device vibrate if posible
    func shakeAndVibrate() {
        shake()
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
}


extension UIView: ShakeableViewProtocol {
    
}