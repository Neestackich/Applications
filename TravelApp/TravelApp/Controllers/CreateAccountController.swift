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
import Firebase
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
    @IBOutlet weak var backToWelcomeScreenButton: UIBarButtonItem!
    
    var databasePath: String = "accounts.realm"
    
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        createAccButton.layer.cornerRadius = 5
        passwordField.isSecureTextEntry = true
        emailField.keyboardType = .emailAddress
        passwordCheckField.isSecureTextEntry = true
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(keyboardHide)))
    }
    
    
    // MARK: -event handlers
    
    @IBAction func backToWelcomeScreenClick(_ sender: Any) {
        let welcomeScreenVC = storyboard?.instantiateViewController(withIdentifier: "WelcomeScreen") as! WelcomePageController
        welcomeScreenVC.modalPresentationStyle = .fullScreen
        
        present(welcomeScreenVC, animated: true)
    }
    
    @IBAction func showPasswordClick(_ sender: Any) {
        buttonPressAnimatio(objects: showPasswordBtn, duration: 0.1, resizeDuration: 0.1, x: 0.6, y: 0.6, resizeX: 1, resizeY: 1)
        
        if passwordField.isSecureTextEntry {
            passwordField.isSecureTextEntry = false
            slowedColorChange(objects: showPasswordBtn, color: .systemBlue, duration: 0.5)
            slowedImageChange(objects: showPasswordBtn, image: UIImage(systemName: "eye"), duration: 0.5)
        } else {
            passwordField.isSecureTextEntry = true
            slowedColorChange(objects: showPasswordBtn, color: .systemGray4, duration: 0.5)
            slowedImageChange(objects: showPasswordBtn, image: UIImage(systemName: "eye.slash"), duration: 0.5)
        }
    }
    
    @IBAction func showPasswordCheckClick(_ sender: Any) {
        buttonPressAnimatio(objects: showPasswordCheckBtn, duration: 0.1, resizeDuration: 0.1, x: 0.6, y: 0.6, resizeX: 1, resizeY: 1)
        
        if passwordCheckField.isSecureTextEntry {
            passwordCheckField.isSecureTextEntry = false
            slowedColorChange(objects: showPasswordCheckBtn, color: .systemBlue, duration: 0.5)
            slowedImageChange(objects: showPasswordCheckBtn, image: UIImage(systemName: "eye"), duration: 0.5)
        } else {
            passwordCheckField.isSecureTextEntry = true
            slowedColorChange(objects: showPasswordCheckBtn, color: .systemGray4, duration: 0.5)
            slowedImageChange(objects: showPasswordCheckBtn, image: UIImage(systemName: "eye.slash"), duration: 0.5)
        }
    }
    
    @IBAction func createAccountClick(_ sender: Any) {
        buttonPressAnimatio(objects: createAccButton, duration: 0.1, resizeDuration: 0.4, x: 0.7, y: 0.9, resizeX: 1, resizeY: 1)
        
        if areTextFieldsValid() {
//            var realmConfiguration = Realm.Configuration()
//            realmConfiguration.fileURL = realmConfiguration.fileURL?.deletingLastPathComponent().appendingPathComponent(databasePath)
//
//            let usersList = try! Realm(configuration: realmConfiguration)
//
//            if usersList.objects(User.self).filter("email = '\(email)'").count == 0 {
//                let user = User(firstName: firstName, lastName: lastName, email: email, nickName: nickName, password: password)
//
////                try! usersList.write {
////                    usersList.add(user)
////                }
//
////                slowedColorChange(objects: emailUnderline, nickNameUnderline, passwordUnderline, passwordCheckUnderline, firstNameUnderline, lastNameUnderline,color: UIColor.systemGreen, duration: 0.5)
////
////                let travelsListVC = storyboard?.instantiateViewController(identifier: "Travels list") as! TravelListViewController
////                travelsListVC.modalPresentationStyle = .fullScreen
////                travelsListVC.user = user
////
////                present(travelsListVC, animated: true)
//            } else {
//                //email already exists
//                emailField.isHighlighted = true
//                slowedColorChange(objects: emailUnderline, color: .red, duration: 1.3)
//            }
            
            
            
            
            
            
        }
    }
    
    
    // MARK: -validation check
    
    private func areTextFieldsValid() -> Bool {
        
        if emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" && nicknameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" && firstNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" && lastNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" && passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" && passwordCheckField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            if (emailField.text?.isEmpty)! {
                slowedColorChange(objects: emailUnderline, color: .red, duration: 1.3)
            }
            
            if (firstNameField.text?.isEmpty)! {
                slowedColorChange(objects: firstNameUnderline, color: .red, duration: 1.3)
            }
            
            if (lastNameField.text?.isEmpty)! {
                slowedColorChange(objects: lastNameUnderline, color: .red, duration: 1.3)
            }
            
            if (nicknameField.text?.isEmpty)! {
                slowedColorChange(objects: nickNameUnderline, color: .red, duration: 1.3)
            }
            
            if (passwordField.text?.isEmpty)! {
                slowedColorChange(objects: passwordUnderline, color: .red, duration: 1.3)
            }
            
            if (passwordCheckField.text?.isEmpty)! {
                slowedColorChange(objects: passwordCheckUnderline, color: .red, duration: 1.3)
            }

            return false
        } else {
            
            return isPasswordValid()
        }
    }
    
    private func isPasswordValid() -> Bool {
        if let password = passwordField.text, let passwordCheck = passwordCheckField.text {
            if password == passwordCheck {
                let passwordPattern = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Z].*[A-Z])(?=.*[!@#$&*])(?=.*[0-9].*[0-9])(?=.*[a-z].*[a-z].*[a-z]).{8}$")
                
                if passwordPattern.evaluate(with: password) {
                   
                    return true
                } else {
                    // хз на кой черт надо, потом проверю
                    // passwordCheckField.isHighlighted = true
                    slowedColorChange(objects: passwordUnderline, color: .red, duration: 1.3)
                    slowedColorChange(objects: passwordCheckUnderline, color: .red, duration: 1.3)
                }
            } else {
                passwordCheckField.isHighlighted = true
                slowedColorChange(objects: passwordCheckUnderline, color: .red, duration: 1.3)
            }
        }
        
        return false
    }
    
    
    // MARK: -text field editing functions
    
    @objc func keyboardHide() {
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if firstNameField.isEditing {
            slowedColorChange(objects: firstNameUnderline, color: .systemGray4, duration: 1.3)
        } else if lastNameField.isEditing {
            scrollView.setContentOffset(CGPoint(x: 0, y: 100), animated: true)
            slowedColorChange(objects: lastNameUnderline, color: .systemGray4, duration: 1.3)
        } else if emailField.isEditing {
            scrollView.setContentOffset(CGPoint(x: 0, y: 150), animated: true)
            slowedColorChange(objects: emailUnderline, color: .systemGray4, duration: 1.3)
        } else if nicknameField.isEditing {
            scrollView.setContentOffset(CGPoint(x: 0, y: 200), animated: true)
            slowedColorChange(objects: nickNameUnderline, color: .systemGray4, duration: 1.3)
        } else if passwordField.isEditing {
            scrollView.setContentOffset(CGPoint(x: 0, y: 280), animated: true)
            slowedColorChange(objects: passwordUnderline, color: .systemGray4, duration: 1.3)
        } else if passwordCheckField.isEditing {
            scrollView.setContentOffset(CGPoint(x: 0, y: 300), animated: true)
            slowedColorChange(objects: passwordCheckUnderline, color: .systemGray4, duration: 1.3)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    
    // MARK: -color changing generic functions
    
    private func slowedColorChange<T: UIView>(objects: T..., color: UIColor, duration: TimeInterval) {
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
    
    private func slowedImageChange<T: UIButton>(objects: T..., image: UIImage?, duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: {
            for object in objects {
                object.setImage(image, for: .normal)
            }
        })
    }
    
    private func buttonPressAnimatio<T: UIButton>(objects: T..., duration: TimeInterval, resizeDuration: TimeInterval, x: CGFloat, y: CGFloat, resizeX: CGFloat, resizeY: CGFloat) {
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
    
    private func rotate<T: UIView>(objects: T..., duration: TimeInterval, angle: CGFloat) {
        UIView.animate(withDuration: duration, animations: {
            for object in objects {
                object.transform = CGAffineTransform(rotationAngle: angle)
            }
        })
    }
}
