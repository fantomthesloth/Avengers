//
//  ViewController.swift
//  Avengers
//
//  Created by DEIK on 2018. 11. 22..
//  Copyright © 2018. Tamás Magyar. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController{
    
    var selectedAvenger = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedAvenger
    }


}

