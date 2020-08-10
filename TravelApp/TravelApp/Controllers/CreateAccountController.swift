//
//  CreateAccountController.swift
//  TravelApp
//
//  Created by Neestackich on 09.08.2020.
//  Copyright © 2020 Neestackich. All rights reserved.
//

import UIKit
import RealmSwift

class CreateAccountController: UIViewController, UITextFieldDelegate {
    
    
    // MARK: properties
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var createAccButton: UIButton!
    @IBOutlet weak var nicknameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var passwordCheckField: UITextField!
    @IBOutlet weak var stackWithFieldsAndButtons: UIStackView!
    
    
    // MARK: methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(keyboardHide)))
        
        createAccButton.layer.cornerRadius = 5
    }
    
    @objc func keyboardHide() {
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if lastNameField.isEditing {
            scrollView.setContentOffset(CGPoint(x: 0, y: 100), animated: true)
        } else if emailField.isEditing {
            scrollView.setContentOffset(CGPoint(x: 0, y: 150), animated: true)
        } else if nicknameField.isEditing {
            scrollView.setContentOffset(CGPoint(x: 0, y: 200), animated: true)
        } else if passwordField.isEditing  {
            scrollView.setContentOffset(CGPoint(x: 0, y: 280), animated: true)
        } else if passwordCheckField.isEditing  {
            scrollView.setContentOffset(CGPoint(x: 0, y: 300), animated: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
}
