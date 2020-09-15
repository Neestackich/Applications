//
//  LoginWithEmailController.swift
//  TravelApp
//
//  Created by Neestackich on 07.08.2020.
//  Copyright © 2020 Neestackich. All rights reserved.
//

// баг с перемещениес кнопки от клавы
// короче это из-за стайла филдов
// если ставить дефолт - все работает


import UIKit
import RealmSwift
import Firebase

class LoginWithEmailController: UIViewController, UITextFieldDelegate, ViewControllerDelegate {
    
    
    // MARK: Properties
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailUnderline: UIView!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var showPasswordBtn: UIButton!
    @IBOutlet weak var passwordUnderline: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var stackWithLabelsAndBtn: UIStackView!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    
    var databasePath: String = "usersDatabase"
    
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        loadingActivityIndicator.alpha = 0
        loginButton.layer.cornerRadius = 5
        loadingActivityIndicator.isHidden = true
        // passwordTextField.isSecureTextEntry = true
        // emailTextField.keyboardType = .emailAddress
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboardByTap)))
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    
    // MARK: -delegate pattern method
    
    func updateInterfaceElements() {
        loginButton.isHidden = false
        loadingActivityIndicator.isHidden = true
        loadingActivityIndicator.stopAnimating()
        
        textFieldsCleaner(textFields: emailTextField, passwordTextField)
        
        AnimationManager.shared.slowedAppearance(objects: loginButton, duration: 0.1)
        AnimationManager.shared.slowedColorChange(objects: emailUnderline, passwordUnderline, color: .systemGray4, duration: 0.1)
    }
    
    
    // MARK: -event handlers
    
    @IBAction func backToWelcomeScreenClick(_ sender: Any) {
        let welcomeScreenVC = storyboard?.instantiateViewController(withIdentifier: "WelcomeScreen") as! WelcomePageController
        welcomeScreenVC.modalPresentationStyle = .fullScreen
        
        present(welcomeScreenVC, animated: true)
    }
    
    @IBAction func loginClick(_ sender: Any) {
        AnimationManager.shared.buttonPressAnimatio(objects: loginButton, duration: 0.1, resizeDuration: 0.4, x: 0.7, y: 0.9, resizeX: 1, resizeY: 1)
        AnimationManager.shared.slowedDisappearance(objects: loginButton, duration: 0.5)
        AnimationManager.shared.slowedAppearance(objects: loadingActivityIndicator, duration: 1.5)
        
        hideKeyboardByTap()
        loadingActivityIndicator.isHidden = false
        loadingActivityIndicator.startAnimating()
        
        if areTextFieldsValid() {
            if let email = emailTextField.text, let password = passwordTextField.text {
                DatabaseManager.shared.signInFirebaseUser(email: email, password: password, emailUnderline: emailUnderline, passwordUnderline: passwordUnderline, loginButton: loginButton, activityIndicator: loadingActivityIndicator) {
                    let travelListVC = self.storyboard?.instantiateViewController(withIdentifier: "TravelListViewController") as! TravelListViewController
                    travelListVC.modalPresentationStyle = .fullScreen
                    travelListVC.viewControllerDelegate = self
                    
                    self.present(travelListVC, animated: true)
                }
            }
        } else {
            loginButton.isHidden = false
            loadingActivityIndicator.isHidden = true
            loadingActivityIndicator.stopAnimating()
            
            AnimationManager.shared.slowedAppearance(objects: loginButton, duration: 0.5)
        }
    }
    
    func userLogin() {
        if let email = emailTextField.text, let password = passwordTextField.text {
            
        }
    }
    
    func areTextFieldsValid() -> Bool {
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" && passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            if (emailTextField.text?.isEmpty)! {
                AnimationManager.shared.slowedColorChange(objects: emailUnderline, color: .systemRed, duration: 0.5)
            }
            
            if (passwordTextField.text?.isEmpty)! {
                AnimationManager.shared.slowedColorChange(objects: passwordUnderline, color: .systemRed, duration: 0.5)
            }
            
            return false
        } else {
            return true
        }
    }
    
    @IBAction func showPasswordClick(_ sender: Any) {
        if passwordTextField.isSecureTextEntry {
            passwordTextField.isSecureTextEntry = false
            AnimationManager.shared.slowedColorChange(objects: showPasswordBtn, color: UIColor.systemBlue, duration: 0.5)
            AnimationManager.shared.slowedImageChange(objects: showPasswordBtn, image: UIImage(systemName: "eye"), duration: 0.5)
        } else {
            passwordTextField.isSecureTextEntry = true
            AnimationManager.shared.slowedColorChange(objects: showPasswordBtn, color: UIColor.systemGray, duration: 0.5)
            AnimationManager.shared.slowedImageChange(objects: showPasswordBtn, image: UIImage(systemName: "eye.slash"), duration: 0.5)
        }
    }
    
    @IBAction func forgotPasswordClick(_ sender: Any) {
        let forgotPasswordVC = storyboard?.instantiateViewController(withIdentifier: "ForgotPassword") as! ForgotPasswordController
        forgotPasswordVC.modalPresentationStyle = .fullScreen
        
        present(forgotPasswordVC, animated: true)
    }
    
    
    // MARK: -text fields editing functions
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if emailTextField.isEditing {
            AnimationManager.shared.slowedColorChange(objects: emailUnderline, color: .systemGray4, duration: 0.5)
        }  else if passwordTextField.isEditing {
            AnimationManager.shared.slowedColorChange(objects: passwordUnderline, color: .systemGray4, duration: 0.5)
        }
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
    
    func textFieldsCleaner(textFields: UITextField...) {
        for textField in textFields {
            textField.text?.removeAll()
        }
    }
}
