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
import FirebaseAuth
import FirebaseFirestore


class CreateAccountViewController: UIViewController, UITextFieldDelegate, ViewControllerDelegate {
        
    
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
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        createAccButton.layer.cornerRadius = 5
        passwordField.isSecureTextEntry = true
        emailField.keyboardType = .emailAddress
        loadingActivityIndicator.isHidden = true
        passwordCheckField.isSecureTextEntry = true
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(keyboardHide)))
    }
    
    
    func updateInterfaceElements() {
        createAccButton.isHidden = false
        loadingActivityIndicator.isHidden = true
        loadingActivityIndicator.stopAnimating()
        
        
        textFieldsCleaner(textFields: emailField, nicknameField, passwordField, lastNameField, firstNameField, passwordCheckField)
        
        AnimationManager.shared.slowedAppearance(objects: createAccButton, emailUnderline, lastNameUnderline, nickNameUnderline, passwordUnderline, firstNameUnderline, passwordCheckUnderline, duration: 0.1)
        
    }
    
    
    // MARK: -event handlers
    
    @IBAction func backToWelcomeScreenClick(_ sender: Any) {
        let welcomeScreenVC = storyboard?.instantiateViewController(withIdentifier: "WelcomeScreen") as! WelcomePageViewController
        welcomeScreenVC.modalPresentationStyle = .fullScreen
        
        present(welcomeScreenVC, animated: true)
    }
    
    @IBAction func showPasswordClick(_ sender: Any) {
        AnimationManager.shared.buttonPressAnimatio(objects: showPasswordBtn, duration: 0.1, resizeDuration: 0.1, x: 0.6, y: 0.6, resizeX: 1, resizeY: 1)
        
        if passwordField.isSecureTextEntry {
            passwordField.isSecureTextEntry = false
            AnimationManager.shared.slowedColorChange(objects: showPasswordBtn, color: .systemBlue, duration: 0.5)
            AnimationManager.shared.slowedImageChange(objects: showPasswordBtn, image: UIImage(systemName: "eye"), duration: 0.5)
        } else {
            passwordField.isSecureTextEntry = true
            AnimationManager.shared.slowedColorChange(objects: showPasswordBtn, color: .systemGray4, duration: 0.5)
            AnimationManager.shared.slowedImageChange(objects: showPasswordBtn, image: UIImage(systemName: "eye.slash"), duration: 0.5)
        }
    }
    
    @IBAction func showPasswordCheckClick(_ sender: Any) {
        AnimationManager.shared.buttonPressAnimatio(objects: showPasswordCheckBtn, duration: 0.1, resizeDuration: 0.1, x: 0.6, y: 0.6, resizeX: 1, resizeY: 1)
        
        if passwordCheckField.isSecureTextEntry {
            passwordCheckField.isSecureTextEntry = false
            AnimationManager.shared.slowedColorChange(objects: showPasswordCheckBtn, color: .systemBlue, duration: 0.5)
            AnimationManager.shared.slowedImageChange(objects: showPasswordCheckBtn, image: UIImage(systemName: "eye"), duration: 0.5)
        } else {
            passwordCheckField.isSecureTextEntry = true
            AnimationManager.shared.slowedColorChange(objects: showPasswordCheckBtn, color: .systemGray4, duration: 0.5)
            AnimationManager.shared.slowedImageChange(objects: showPasswordCheckBtn, image: UIImage(systemName: "eye.slash"), duration: 0.5)
        }
    }
    
    @IBAction func createAccountClick(_ sender: Any) {
        AnimationManager.shared.buttonPressAnimatio(objects: createAccButton, duration: 0.1, resizeDuration: 0.4, x: 0.7, y: 0.9, resizeX: 1, resizeY: 1)
        AnimationManager.shared.slowedDisappearance(objects: createAccButton, duration: 0.5)
        AnimationManager.shared.slowedAppearance(objects: loadingActivityIndicator, duration: 1.5)
        
        keyboardHide()
        loadingActivityIndicator.isHidden = false
        loadingActivityIndicator.startAnimating()
        
        if areTextFieldsValid() {
            if let email = emailField.text, let password = passwordField.text, let nickName = nicknameField.text, let firstName = firstNameField.text, let lastName = lastNameField.text {
                DatabaseManager.shared.createFirebaseUser(email: email, password: password, firstName: firstName, lastName: lastName, nickName: nickName, emailUnderline: emailUnderline, createAccButton: createAccButton, activityIndicator: loadingActivityIndicator, passwordUnderline: passwordUnderline) {
                    let travelListVC = self.storyboard?.instantiateViewController(withIdentifier: "TravelListViewController") as! TravelListViewController
                    travelListVC.modalPresentationStyle = .fullScreen
                    travelListVC.viewControllerDelegate = self
                    
                    self.present(travelListVC, animated: true)
                }
            }
        } else {
            createAccButton.isHidden = false
            loadingActivityIndicator.isHidden = true
            loadingActivityIndicator.stopAnimating()
            
            AnimationManager.shared.slowedAppearance(objects: createAccButton, duration: 0.5)
        }
    }
    
    
    // MARK: -validation check
    
    private func areTextFieldsValid() -> Bool {
        
        if emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" && nicknameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" && firstNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" && lastNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" && passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" && passwordCheckField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            if (emailField.text?.isEmpty)! {
                AnimationManager.shared.slowedColorChange(objects: emailUnderline, color: .red, duration: 1.3)
            }
            
            if (firstNameField.text?.isEmpty)! {
                AnimationManager.shared.slowedColorChange(objects: firstNameUnderline, color: .red, duration: 1.3)
            }
            
            if (lastNameField.text?.isEmpty)! {
                AnimationManager.shared.slowedColorChange(objects: lastNameUnderline, color: .red, duration: 1.3)
            }
            
            if (nicknameField.text?.isEmpty)! {
                AnimationManager.shared.slowedColorChange(objects: nickNameUnderline, color: .red, duration: 1.3)
            }
            
            if (passwordField.text?.isEmpty)! {
                AnimationManager.shared.slowedColorChange(objects: passwordUnderline, color: .red, duration: 1.3)
            }
            
            if (passwordCheckField.text?.isEmpty)! {
                AnimationManager.shared.slowedColorChange(objects: passwordCheckUnderline, color: .red, duration: 1.3)
            }

            return false
        } else {
            
            return isPasswordValid()
        }
    }
    
    private func isPasswordValid() -> Bool {
        if let password = passwordField.text, let passwordCheck = passwordCheckField.text {
            if password == passwordCheck {
                
                return true
            } else {
                passwordCheckField.isHighlighted = true
                AnimationManager.shared.slowedColorChange(objects: passwordCheckUnderline, color: .red, duration: 1.3)
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
            AnimationManager.shared.slowedColorChange(objects: firstNameUnderline, color: .systemGray4, duration: 1.3)
        } else if lastNameField.isEditing {
            scrollView.setContentOffset(CGPoint(x: 0, y: 100), animated: true)
            AnimationManager.shared.slowedColorChange(objects: lastNameUnderline, color: .systemGray4, duration: 1.3)
        } else if emailField.isEditing {
            scrollView.setContentOffset(CGPoint(x: 0, y: 150), animated: true)
            AnimationManager.shared.slowedColorChange(objects: emailUnderline, color: .systemGray4, duration: 1.3)
        } else if nicknameField.isEditing {
            scrollView.setContentOffset(CGPoint(x: 0, y: 200), animated: true)
            AnimationManager.shared.slowedColorChange(objects: nickNameUnderline, color: .systemGray4, duration: 1.3)
        } else if passwordField.isEditing {
            scrollView.setContentOffset(CGPoint(x: 0, y: 280), animated: true)
            AnimationManager.shared.slowedColorChange(objects: passwordUnderline, color: .systemGray4, duration: 1.3)
        } else if passwordCheckField.isEditing {
            scrollView.setContentOffset(CGPoint(x: 0, y: 300), animated: true)
            AnimationManager.shared.slowedColorChange(objects: passwordCheckUnderline, color: .systemGray4, duration: 1.3)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    func textFieldsCleaner(textFields: UITextField...) {
        for textField in textFields {
            textField.text?.removeAll()
        }
    }
}
