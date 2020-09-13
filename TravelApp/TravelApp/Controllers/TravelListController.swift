//
//  TravelListController.swift
//  TravelApp
//
//  Created by Neestackich on 07.08.2020.
//  Copyright © 2020 Neestackich. All rights reserved.
//


import UIKit
import RealmSwift


class TravelListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    // MARK: - Properties
    
    @IBOutlet weak var noTravelsLabel: UILabel!
    @IBOutlet weak var travelsTable: UITableView!
    
    weak var viewControllerDelegate: ViewControllerDelegate!
    
    var travelsList: [Travel] = []
    let travelAddID: String = "TravelAdd"
    
    
    // MARK: - Methods
    
    // срабатывает когда экран был загружен, верстки еще нету
    // размеры элементов будут еще как в сториборде
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
//    // перед тем, как вьюшка появится
//    // тоже не сверстано
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//    }
//
//    // когда вьюшка уже появилась
//    // уже сверстано
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//    }
//
//    // сработает перед тем, как закроется экран
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//    }
//
//    // сработает, когда закроется экран полностью
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//    }
    
    
    func setup() {
        travelsTable.delegate = self
        travelsTable.dataSource = self
        travelsTable.separatorStyle = .none
        travelsTable.layer.cornerRadius = 15
    
        DatabaseManager.shared.addFirestoreUserToRealm(action: nil)
        
        let travelsFromDatabase = DatabaseManager.shared.getRealmTravels()

        if let travelsFromDatabase = travelsFromDatabase {
            for singleTravel in travelsFromDatabase {
                travelsList.append(singleTravel)
            }
        }
        
        if travelsList.count == 0 {
            noTravelsLabel.text = "У вас не создано ни одной точки маршрута. \nНажмите \"+\", чтобы добавить."
        } else {
            noTravelsLabel.text?.removeAll()
        }
    }
    
    
    // MARK: - buttons' event handlers
    
    @IBAction func addTravelClick(_ sender: Any) {
        let createTravelVC = storyboard?.instantiateViewController(withIdentifier: travelAddID) as! CreateTravelController
        createTravelVC.modalPresentationStyle = .fullScreen
        present(createTravelVC, animated: true)
    }
    
    @IBAction func quitClick(_ sender: Any) {
        DatabaseManager.shared.clearObjects()
        viewControllerDelegate.updateInterfaceElements()
        
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - tableview methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var counter = 1
        let travel = travelsList[indexPath.row]
        let travelCell = tableView.dequeueReusableCell(withIdentifier: "TravelCell") as! TravelCell
        travelCell.countryName.text = travel.country
        travelCell.countryDescription.text = travel.travelDescription
        
        for subview in travelCell.raitingStack.arrangedSubviews {
            if counter <= travel.raiting {
                slowedColorChange(objects: subview, color: .systemOrange, duration: 0.1)
            }
            
            counter += 1
        }
        
        return travelCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stopsVC = storyboard?.instantiateViewController(identifier: "StopsList") as! StopsListController
        stopsVC.modalPresentationStyle = .fullScreen
        stopsVC.travelIndex = indexPath.row
        stopsVC.travelid = travelsList[indexPath.row].travelid
        
        present(stopsVC, animated: true)
    }
    
    
    // MARK: - animation methods
    
    func slowedColorChange<T: UIView>(objects: T..., color: UIColor, duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: {
            for object in objects {
                if object is UIImageView {
                    object.tintColor = color
                } else {
                    object.backgroundColor = color
                }
            }
        })
    }
}
