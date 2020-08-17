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
import RealmSwift

class TravelListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    // MARK: Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var travelsTable: UITableView!
    @IBOutlet weak var noTravelsLabel: UILabel!
    
    var user: User!
    var travelsList: [Travel] = []
    let travelAddID: String = "TravelAdd"
    
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setup()
    }
    
    func setup() {
        travelsTable.delegate = self
        travelsTable.dataSource = self
        travelsTable.separatorStyle = .none
        travelsTable.layer.cornerRadius = 15
        
        var config = Realm.Configuration()
        config.fileURL = config.fileURL?.deletingLastPathComponent().appendingPathComponent("\(user.email).realm")
        let usersTravels = try! Realm(configuration: config)
        let travelsFromDB = usersTravels.objects(Travel.self)
        
        for singleTravel in travelsFromDB {
            travelsList.append(singleTravel)
        }
        
        if travelsList.count == 0 {
            noTravelsLabel.text = "У вас не создано ни одной точки маршрута. \nНажмите \"+\", чтобы добавить."
        } else {
            noTravelsLabel.text?.removeAll()
        }
    }
    
    
    // MARK: -buttons' event handlers
    
    @IBAction func addTravelClick(_ sender: Any) {
        let createTravelVC = storyboard?.instantiateViewController(withIdentifier: travelAddID) as! CreateTravelController
        createTravelVC.modalPresentationStyle = .fullScreen
        createTravelVC.user = user
        
        present(createTravelVC, animated: true)
    }
    
    @IBAction func quitClick(_ sender: Any) {
        let welcomeScreenVC = storyboard?.instantiateViewController(identifier: "WelcomeScreen") as! WelcomePageController
        welcomeScreenVC.modalPresentationStyle = .fullScreen
        
        present(welcomeScreenVC, animated: true)
    }
    
    
    // MARK: -table view methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let travel = travelsList[indexPath.row]
        let travelCell = tableView.dequeueReusableCell(withIdentifier: "TravelCell") as! TravelCell
        travelCell.countryName.text = travel.country
        travelCell.countryDescription.text = travel.travelDescription
        
        return travelCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stopsVC = storyboard?.instantiateViewController(identifier: "StopsList") as! StopsListController
        stopsVC.modalPresentationStyle = .fullScreen
        stopsVC.travel = travelsList[indexPath.row]
        stopsVC.travelIndex = indexPath.row
        stopsVC.user = user
        
        present(stopsVC, animated: true)
    }
}
