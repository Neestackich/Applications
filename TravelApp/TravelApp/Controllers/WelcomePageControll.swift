//
//  WelcomePageController.swift
//  TravelApp
//
//  Created by Neestackich on 06.08.2020.
//  Copyright © 2020 Neestackich. All rights reserved.
//

import UIKit

class WelcomePageController: UIViewController {
    
    
    // MARK: Properties
    
    @IBOutlet weak var mainPic: UIImageView!
    @IBOutlet weak var emailLogin: UIButton!
    @IBOutlet weak var createAccount: UIButton!
    @IBOutlet weak var moreWaysToLogin: UIButton!
    
    
    // MARK: Methods

    override func loadView() {
        super.loadView()
        
        UIView.animate(withDuration: 1, animations: {
            self.mainPic.transform = CGAffineTransform(rotationAngle: 90)
        })
        
        createAccount.layer.cornerRadius = 5
        emailLogin.layer.cornerRadius = 5
    }
    
    
    // MARK: -event handlers
    
    @IBAction func createAccountClick(_ sender: Any) {
        buttonPressAnimation(objects: createAccount, duration: 0.1, resizeDuration: 0.1, x: 0.7, y: 0.9, resizeX: 1, resizeY: 1)
    }
    
    @IBAction func loginWithEmail(_ sender: Any) {
        buttonPressAnimation(objects: emailLogin, duration: 0.1, resizeDuration: 0.1, x: 0.7, y: 0.9, resizeX: 1, resizeY: 1)
    }
    
    
    // MARK: -animation function
    
    func buttonPressAnimation<T: UIView>(objects: T..., duration: TimeInterval, resizeDuration: TimeInterval, x: CGFloat, y: CGFloat, resizeX: CGFloat, resizeY: CGFloat) {
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
}
