//
//  StopCell.swift
//  TravelApp
//
//  Created by Neestackich on 16.08.2020.
//  Copyright © 2020 Neestackich. All rights reserved.
//

import UIKit

class StopCell: UITableViewCell {
    
    
    // MARK: Properties
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var moneySpend: UILabel!
    @IBOutlet weak var stopDescription: UILabel!
    @IBOutlet weak var raitingStack: UIStackView!
    @IBOutlet weak var transportPic: UIImageView!
    
    
    // MARK: Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    func setup() {
        cellView.layer.cornerRadius = 15
        transportPic.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
