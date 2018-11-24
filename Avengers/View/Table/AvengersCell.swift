//
//  Avengers.swift
//  Avengers
//
//  Created by DEIK on 2018. 11. 22..
//  Copyright © 2018. Tamás Magyar. All rights reserved.
//

import UIKit

class AvengersCell: UITableViewCell {
    
    @IBOutlet var avengersPicture: UIImageView!
    @IBOutlet var avengersName: UILabel!
    @IBOutlet var distance: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
