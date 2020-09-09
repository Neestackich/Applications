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

class LoginWithEmailController: UIViewController, UITextFieldDelegate {
    
    
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

    var databasePath: String = "usersDatabase"
    
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        loginButton.layer.cornerRadius = 5
        emailTextField.keyboardType = .emailAddress
        passwordTextField.isSecureTextEntry = true
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboardByTap)))
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    
    // MARK: -event handlers
    
    @IBAction func backToWelcomeScreenClick(_ sender: Any) {
        let welcomeScreenVC = storyboard?.instantiateViewController(withIdentifier: "WelcomeScreen") as! WelcomePageController
        welcomeScreenVC.modalPresentationStyle = .fullScreen
        
        present(welcomeScreenVC, animated: true)
    }
    
    @IBAction func loginClick(_ sender: Any) {
        buttonPressAnimatio(objects: loginButton, duration: 0.1, resizeDuration: 0.4, x: 0.7, y: 0.9, resizeX: 1, resizeY: 1)
        
        if areTextFieldsValid() {
            if let email = emailTextField.text, let password = passwordTextField.text {
                if let errorCode = DatabaseManager.shared.signInFirebaseUser(email: email, password: password) {
                    switch errorCode {
                    case .wrongPassword:
                        self.slowedColorChange(objects: self.passwordUnderline, color: UIColor.red, duration: 0.5)
                    case .invalidEmail:
                        self.slowedColorChange(objects: self.emailUnderline, color: UIColor.red, duration: 0.5)
                    default:
                        break
                    }
                }
            }
            
            let travelListVC = storyboard?.instantiateViewController(withIdentifier: "Travels list") as! TravelListViewController
            travelListVC.modalPresentationStyle = .fullScreen
            present(travelListVC, animated: true)
            
           // DatabaseManager.shared.getStops()
            
            
//            var config = Realm.Configuration()
//            config.fileURL = config.fileURL?.deletingLastPathComponent().appendingPathComponent(databasePath)
//            config.readOnly = false
//
//            let usersList = try! Realm(configuration: config)
//
//            if usersList.objects(User.self).filter("email = '\(email)'").count != 0 {
//                let user = usersList.objects(User.self).filter("email = '\(email)'").first
//
//                if (user?.password)! == password {
//                slowedColorChange(objects: emailUnderline, color: UIColor.systemGreen, duration: 0.2)
//                slowedColorChange(objects: passwordUnderline, color: UIColor.systemGreen, duration: 0.2)
//
//                if let userObject = user {
//                    let travelListVC = storyboard?.instantiateViewController(identifier: "Travels list") as! TravelListViewController
//                    travelListVC.modalPresentationStyle = .fullScreen
//                    travelListVC.user = userObject
//
//                    present(travelListVC, animated: true)
//                    }
//                } else {
//                    //wrong password
//                    slowedColorChange(objects: passwordUnderline, color: UIColor.red, duration: 1)
//                }
//            } else {
//                //no account with such email
//                slowedColorChange(objects: emailUnderline, color: UIColor.red, duration: 0.5)
//                slowedColorChange(objects: passwordUnderline, color: UIColor.red, duration: 0.5)
//            }
            
            
            
//            switch errorCode {
//            case .wrongPassword:
//                self.slowedColorChange(objects: self.passwordUnderline, color: UIColor.red, duration: 0.5)
//            case .invalidEmail:
//                self.slowedColorChange(objects: self.emailUnderline, color: UIColor.red, duration: 0.5)
//            default:
//                break
//            }
            
        }
    }
    
    func userLogin() {
        if let email = emailTextField.text, let password = passwordTextField.text {
            
        }
    }
    
    func areTextFieldsValid() -> Bool {
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" && passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            if (emailTextField.text?.isEmpty)! {
                slowedColorChange(objects: emailUnderline, color: UIColor.red, duration: 0.5)
            }
            
            if (passwordTextField.text?.isEmpty)! {
                slowedColorChange(objects: passwordUnderline, color: UIColor.red, duration: 0.5)
            }
            
            return false
        } else {
            return true
        }
    }
    
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
    
    @IBAction func forgotPasswordClick(_ sender: Any) {
        let forgotPasswordVC = storyboard?.instantiateViewController(withIdentifier: "ForgotPassword") as! ForgotPasswordController
        forgotPasswordVC.modalPresentationStyle = .fullScreen
        
        present(forgotPasswordVC, animated: true)
    }
    
    
    // MARK: -text fields editing functions
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if emailTextField.isEditing {
            slowedColorChange(objects: emailUnderline, color: .systemGray4, duration: 1.3)
        }  else if passwordTextField.isEditing {
            slowedColorChange(objects: passwordUnderline, color: .systemGray4, duration: 1.3)
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
    
    
    // MARK: -color and other props changing generic functions
    
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
}
