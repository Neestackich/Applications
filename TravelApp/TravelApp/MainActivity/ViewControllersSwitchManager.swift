//
//  ViewControllersSwitchManager.swift
//  TravelApp
//
//  Created by Neestackich on 12.09.2020.
//  Copyright © 2020 Neestackich. All rights reserved.
//

import UIKit

class ViewControllersSwitchManager: UIViewController {
    
    
    // MARK: - Properties
    
    static let shared = ViewControllersSwitchManager()
    
    
    // MARK: - Methods
    
    func switchToViewController<T: UIViewController>(viewControllerType: T.Type, identifier: String) {
        var viewController: UIViewController = UIViewController()
        
        switch viewControllerType {
        case is AddStopController.Type:
            viewController = storyboard?.instantiateViewController(withIdentifier: identifier) as! AddStopController
        case is StopsListController.Type:
            viewController = storyboard?.instantiateViewController(withIdentifier: identifier) as! StopsListController
        case is WelcomePageController.Type:
            viewController = storyboard?.instantiateViewController(withIdentifier: identifier) as! WelcomePageController
        case is CreateTravelController.Type:
            viewController = storyboard?.instantiateViewController(withIdentifier: identifier) as! CreateTravelController
        case is AddMoneyValueController.Type:
            viewController = storyboard?.instantiateViewController(withIdentifier: identifier) as! AddMoneyValueController
        case is CreateAccountController.Type:
            viewController = storyboard?.instantiateViewController(withIdentifier: identifier) as! CreateAccountController
        case is LoginWithEmailController.Type:
            viewController = storyboard?.instantiateViewController(withIdentifier: identifier) as! LoginWithEmailController
        case is ForgotPasswordController.Type:
            viewController = storyboard?.instantiateViewController(withIdentifier: identifier) as! ForgotPasswordController
        case is TravelListViewController.Type:
            viewController = storyboard?.instantiateViewController(withIdentifier: "TravelListViewController") as! TravelListViewController
        case is AddMapLocationController.Type:
            viewController = storyboard?.instantiateViewController(withIdentifier: identifier) as! AddMapLocationController
        default:
            break
        }
        
        //if let unwrapperViewController = viewController {
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true)
    }
}
