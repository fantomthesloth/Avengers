//
//  Avengers.swift
//  Avengers
//
//  Created by DEIK on 2018. 11. 22..
//  Copyright © 2018. Tamás Magyar. All rights reserved.
//

import UIKit

class Avengers: Codable {
    let avengers: [Avenger]
    
    init(avengers: [Avenger]){
        self.avengers = avengers
    }
}

class Avenger: Codable {
    let name: String
    let imageURL: String
    let latitude: Double
    let longitude: Double

    init(name: String, imageURL: String, latitude: Double, longitude: Double) {
        self.name = name
        self.imageURL = imageURL
        self.latitude = latitude
        self.longitude = longitude
    }
}


