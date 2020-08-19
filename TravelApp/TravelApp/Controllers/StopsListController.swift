//
//  StopsListController.swift
//  TravelApp
//
//  Created by Neestackich on 16.08.2020.
//  Copyright © 2020 Neestackich. All rights reserved.
//

import UIKit
import RealmSwift

class StopsListController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    // MARK: Properties
    
    @IBOutlet weak var noStopsLabel: UILabel!
    @IBOutlet weak var stopsTableList: UITableView!
    
    var user: User!
    var travel: Travel!
    var travelIndex: Int!
    let addStopVCID: String = "AddStop"
    let travelListVCID: String = "Travels list"
    
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        stopsTableList.delegate = self
        stopsTableList.dataSource = self
        stopsTableList.separatorStyle = .none
        stopsTableList.layer.cornerRadius = 15
        
        if travel.stops.count == 0 {
            noStopsLabel.text = "У вас не создано ни одной точки маршрута. \nНажмите \"+\", чтобы добавить."
        } else {
            noStopsLabel.text?.removeAll()
        }
    }
    
    
    // MARK: -buttons' handlers
    
    @IBAction func backToTravelsListControllerClick(_ sender: Any) {
        let travelsListVC = storyboard?.instantiateViewController(withIdentifier: travelListVCID) as! TravelListViewController
        travelsListVC.modalPresentationStyle = .fullScreen
        travelsListVC.user = user
        
        present(travelsListVC, animated: true)
    }
    
    @IBAction func addStopClick(_ sender: Any) {
        let addStopVC = storyboard?.instantiateViewController(withIdentifier: addStopVCID) as! AddStopController
        addStopVC.modalPresentationStyle = .fullScreen
        addStopVC.user = user
        addStopVC.travel = travel
        addStopVC.travelIndex = travelIndex
        
        present(addStopVC, animated: true)
    }
    
    
    // MARK: -tableView functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travel.stops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var counter = 1
        let stop = travel.stops[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "StopCell") as! StopCell
        cell.cityName.text = stop.stopCityName
        cell.moneySpend.text = stop.spentMoneyValue
        cell.stopDescription.text = stop.stopDescription
        
        for subview in cell.raitingStack.arrangedSubviews {
            if counter <= stop.raiting {
                slowedColorChange(objects: subview, color: .systemOrange, duration: 1)
            }
            
            counter += 1
        }
        
        if stop.transport == 1 {
            cell.transportPic.image = UIImage(named: "car12.png")
        } else if stop.transport == 2 {
            cell.transportPic.image = UIImage(named: "train12.png")
        }
        
        return cell
    }
    
    
    // MARK: -subsidiary functions
    
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
