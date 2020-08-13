//
//  CreateAccountController.swift
//  TravelApp
//
//  Created by Neestackich on 09.08.2020.
//  Copyright © 2020 Neestackich. All rights reserved.
//


//use this to check out realm folder path
//print(usersList.configuration.fileURL)


import UIKit
import RealmSwift

class CreateAccountController: UIViewController, UITextFieldDelegate {
    
    
    // MARK: Properties
    
    @IBOutlet weak var emailUnderline: UIView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lastNameUnderline: UIView!
    @IBOutlet weak var createAccButton: UIButton!
    @IBOutlet weak var nickNameUnderline: UIView!
    @IBOutlet weak var showPasswordBtn: UIButton!
    @IBOutlet weak var passwordUnderline: UIView!
    @IBOutlet weak var firstNameUnderline: UIView!
    @IBOutlet weak var nicknameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var showPasswordCheckBtn: UIButton!
    @IBOutlet weak var passwordCheckUnderline: UIView!
    @IBOutlet weak var passwordCheckField: UITextField!
    @IBOutlet weak var stackWithFieldsAndButtons: UIStackView!
    
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(keyboardHide)))
        
        createAccButton.layer.cornerRadius = 5
        passwordField.isSecureTextEntry = true
        emailField.keyboardType = .emailAddress
        passwordCheckField.isSecureTextEntry = true
    }
    
    
    // MARK: -event handlers
    
    @IBAction func showPasswordClick(_ sender: Any) {
        if passwordField.isSecureTextEntry {
            passwordField.isSecureTextEntry = false
            slowedColorChange(objects: showPasswordBtn, color: UIColor.systemBlue, duration: 0.5)
            slowedImageChange(objects: showPasswordBtn, image: UIImage(systemName: "eye"), duration: 0.5)
        } else {
            passwordField.isSecureTextEntry = true
            slowedColorChange(objects: showPasswordBtn, color: UIColor.systemGray4, duration: 0.5)
            slowedImageChange(objects: showPasswordBtn, image: UIImage(systemName: "eye.slash"), duration: 0.5)
        }
    }
    
    @IBAction func showPasswordCheckClick(_ sender: Any) {
        if passwordCheckField.isSecureTextEntry {
            passwordCheckField.isSecureTextEntry = false
            slowedColorChange(objects: showPasswordCheckBtn, color: UIColor.systemBlue, duration: 0.5)
            slowedImageChange(objects: showPasswordCheckBtn, image: UIImage(systemName: "eye"), duration: 0.5)
        } else {
            passwordCheckField.isSecureTextEntry = true
            slowedColorChange(objects: showPasswordCheckBtn, color: UIColor.systemGray4, duration: 0.5)
            slowedImageChange(objects: showPasswordCheckBtn, image: UIImage(systemName: "eye.slash"), duration: 0.5)
        }
    }
    
    @IBAction func createAccountClick(_ sender: Any) {
        if let email = emailField.text, !email.isEmpty, let nickName = nicknameField.text,
            !nickName.isEmpty, let firstName = firstNameField.text, !firstName.isEmpty,
            let lastName = lastNameField.text, !lastName.isEmpty, let password = passwordField.text,
            !password.isEmpty, let passwordCheck = passwordCheckField.text, !passwordCheck.isEmpty {
            if password == passwordCheck {
                var realmConfiguration = Realm.Configuration()
                realmConfiguration.fileURL = realmConfiguration.fileURL?.deletingLastPathComponent().appendingPathComponent("usersList.realm")
                
                let usersList = try! Realm(configuration: realmConfiguration)
                
                if usersList.objects(User.self).filter("email = '\(email)'").count == 0 {
                    try! usersList.write {
                        usersList.add(User(firstName: firstName, lastName: lastName, email: email, nickName: nickName, password: password))
                        
                        slowedColorChange(objects: emailUnderline, nickNameUnderline, passwordUnderline, passwordCheckUnderline, firstNameUnderline, lastNameUnderline, color: UIColor.systemGreen, duration: 1.3)
                    }
                } else {
                    //email already exists
                    emailField.isHighlighted = true
                    slowedColorChange(objects: emailUnderline, color: UIColor.red, duration: 1.3)
                }
            } else {
                //wrong passwords
                passwordCheckField.isHighlighted = true
                slowedColorChange(objects: passwordCheckUnderline, color: UIColor.red, duration: 1.3)
            }
        } else {
            //empty fields
            if (emailField.text?.isEmpty)! {
                slowedColorChange(objects: emailUnderline, color: UIColor.red, duration: 1.3)
            }
            
            if (firstNameField.text?.isEmpty)! {
                slowedColorChange(objects: firstNameUnderline, color: UIColor.red, duration: 1.3)
            }
            
            if (lastNameField.text?.isEmpty)! {
                slowedColorChange(objects: lastNameUnderline, color: UIColor.red, duration: 1.3)
            }
            
            if (nicknameField.text?.isEmpty)! {
                slowedColorChange(objects: nickNameUnderline, color: UIColor.red, duration: 1.3)
            }
            
            if (passwordField.text?.isEmpty)! {
                slowedColorChange(objects: passwordUnderline, color: UIColor.red, duration: 1.3)
            }
            
            if (passwordCheckField.text?.isEmpty)! {
                slowedColorChange(objects: passwordCheckUnderline, color: UIColor.red, duration: 1.3)
            }
        }
    }
    
    
    // MARK: -text field editing functions
    
    @objc func keyboardHide() {
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if firstNameField.isEditing {
            slowedColorChange(objects: firstNameUnderline, color: UIColor.systemGray4, duration: 1.3)
        } else if lastNameField.isEditing {
            scrollView.setContentOffset(CGPoint(x: 0, y: 100), animated: true)
            slowedColorChange(objects: lastNameUnderline, color: UIColor.systemGray4, duration: 1.3)
        } else if emailField.isEditing {
            scrollView.setContentOffset(CGPoint(x: 0, y: 150), animated: true)
            slowedColorChange(objects: emailUnderline, color: UIColor.systemGray4, duration: 1.3)
        } else if nicknameField.isEditing {
            scrollView.setContentOffset(CGPoint(x: 0, y: 200), animated: true)
            slowedColorChange(objects: nickNameUnderline, color: UIColor.systemGray4, duration: 1.3)
        } else if passwordField.isEditing  {
            scrollView.setContentOffset(CGPoint(x: 0, y: 280), animated: true)
            slowedColorChange(objects: passwordUnderline, color: UIColor.systemGray4, duration: 1.3)
        } else if passwordCheckField.isEditing  {
            scrollView.setContentOffset(CGPoint(x: 0, y: 300), animated: true)
            slowedColorChange(objects: passwordCheckUnderline, color: UIColor.systemGray4, duration: 1.3)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    
    // MARK: -generic color changing functions
    
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
