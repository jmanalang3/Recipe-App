//
//  UIView+Animation+Extensions.swift
//  Recipe-App
//
//  Created by Jeffrey Manalang (HLB) on 04/10/2020.
//

import UIKit


extension UIView {
    
    func fadeIn(withDuration duration: TimeInterval = 1.0, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: 0.0,
                       options: UIView.AnimationOptions.curveEaseIn, animations: {
                        self.alpha = 1.0
        }, completion: completion)
    }
    
    
    func fadeOut(withDuration duration: TimeInterval = 1.0, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: 0.0,
                       options: UIView.AnimationOptions.curveEaseOut, animations: {
                        self.alpha = 0.0
        }, completion: completion)
    }
}
