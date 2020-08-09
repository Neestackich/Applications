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
    @IBOutlet weak var passwordTextField: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var stackWithLabelsAndBtn: UIStackView!

    
    // MARK: methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboardByTap)))
        
        loginButton.layer.cornerRadius = 5
        emailTextField.keyboardType = .default
    }
    
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
}
