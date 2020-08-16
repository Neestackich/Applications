//
//  TravelListController.swift
//  TravelApp
//
//  Created by Neestackich on 07.08.2020.
//  Copyright © 2020 Neestackich. All rights reserved.
//


//добавить кнопку добавления трэвел в реалм
//просто пихаем объект в реалм по нажатию кнопки и все
//потом кнопка, которая достает нужный объект(ы) из базы

import UIKit

class TravelListViewController: UIViewController, /*UITableViewDataSource*/ UITableViewDelegate {
    
    
    // MARK: Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var travelsTable: UITableView!
    
    var user: User!
    
    let travelAddID: String = "TravelAdd"
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setup()
    }
    
    func setup() {
        //
        travelsTable.delegate = self
        //travelsTable.dataSource = self
    }
    
    @IBAction func addTravelClick(_ sender: Any) {
        let createTravelVC = storyboard?.instantiateViewController(identifier: travelAddID) as! CreateTravelController
        createTravelVC.modalPresentationStyle = .fullScreen
        createTravelVC.userEmail = user?.email
        
        present(createTravelVC, animated: true)
    }
    
    @IBAction func quitClick(_ sender: Any) {
        let welcomeScreenVC = storyboard?.instantiateViewController(identifier: "WelcomeScreen") as! WelcomePageController
        welcomeScreenVC.modalPresentationStyle = .fullScreen
        
        present(welcomeScreenVC, animated: true)
    }
}
