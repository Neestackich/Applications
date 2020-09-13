//
//  AnimationManager.swift
//  TravelApp
//
//  Created by Neestackich on 13.09.2020.
//  Copyright © 2020 Neestackich. All rights reserved.
//

import UIKit

class AnimationManager {
    
    
    // MARK: -properties
    
    static let shared = AnimationManager()
    
    
    // MARK: -color and other props changing generic functions
    
    func slowedColorChange(object: UIView, color: UIColor, duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: {
            if object is UIButton {
                object.tintColor = color
            } else {
                object.backgroundColor = color
            }
        })
    }
    
    func slowedColorChange<T: UIView>(objects: T..., color: UIColor, duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: {
            for object in objects {
                if object is UIButton {
                    object.tintColor = color
                } else {
                    object.backgroundColor = color
                }
            }
        })
    }
    
    func slowedImageChange<T: UIButton>(objects: T..., image: UIImage?, duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: {
            for object in objects {
                object.setImage(image, for: .normal)
            }
        })
    }
    
    func buttonPressAnimatio<T: UIButton>(objects: T..., duration: TimeInterval, resizeDuration: TimeInterval, x: CGFloat, y: CGFloat, resizeX: CGFloat, resizeY: CGFloat) {
        UIView.animate(withDuration: duration, animations: {
            for object in objects {
                object.transform = CGAffineTransform(scaleX: x, y: y)
            }
        }, completion: { _ in
            UIView.animate(withDuration: resizeDuration, animations: {
                for object in objects {
                    object.transform = CGAffineTransform(scaleX: resizeX, y: resizeY)
                }
            })
        })
    }
    
    func slowedDisappearance<T: UIView>(objects: T..., duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: {
            for object in objects {
                object.alpha = 0
                //object.isHidden = true
            }
        })
    }
    
    func slowedAppearance<T: UIView>(objects: T..., duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: {
            for object in objects {
                object.alpha = 1
                object.isHidden = false
            }
        })
    }
}
