//
//  LoginWithEmailController.swift
//  TravelApp
//
//  Created by Neestackich on 07.08.2020.
//  Copyright © 2020 Neestackich. All rights reserved.
//

import UIKit

class LoginWithEmailController: UIViewController, UITextFieldDelegate {
    
    
    // MARK: properties
    

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailUnderline: UIView!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordUnderline: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var showPasswordBtn: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var stackWithLabelsAndBtn: UIStackView!

    
    // MARK: methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboardByTap)))
        
        loginButton.layer.cornerRadius = 5
        emailTextField.keyboardType = .emailAddress
        passwordTextField.isSecureTextEntry = true
    }
    
    
    // MARK: -event handlers
    
    @IBAction func showPasswordClick(_ sender: Any) {
        if passwordTextField.isSecureTextEntry {
            passwordTextField.isSecureTextEntry = false
            slowedColorChange(objects: showPasswordBtn, color: UIColor.systemBlue, duration: 0.5)
            slowedImageChange(objects: showPasswordBtn, image: UIImage(systemName: "eye"), duration: 0.5)
        } else {
            passwordTextField.isSecureTextEntry = true
            slowedColorChange(objects: showPasswordBtn, color: UIColor.systemGray, duration: 0.5)
            slowedImageChange(objects: showPasswordBtn, image: UIImage(systemName: "eye.slash"), duration: 0.5)
        }
    }
    
    
    // MARK: -text fields editing functions
    
    @objc func keyboardDidShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let screenHeightWithKeyboard = UIScreen.main.bounds.height - keyboardSize.height - 15
            
            if screenHeightWithKeyboard <= forgotPasswordButton.center.y {
                forgotPasswordButton.center.y -= forgotPasswordButton.center.y - screenHeightWithKeyboard
                
                if screenHeightWithKeyboard <= stackWithLabelsAndBtn.center.y + 53 {
                    stackWithLabelsAndBtn.center.y += stackWithLabelsAndBtn.center.y - screenHeightWithKeyboard
                }
            }
        }
    }
    
    @objc func hideKeyboardByTap() {
        view.endEditing(true)
    }
    
    
    // MARK: -color changing generic functions
    
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
}
