//
//  FriendsController.swift
//  Avengers
//
//  Created by DEIK on 2018. 11. 22..
//  Copyright © 2018. Tamás Magyar. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class FriendsController: UITableViewController, CLLocationManagerDelegate{
    
    var avengers = [Avenger]()
    
    var userLat: CLLocationDegrees!
    var userLong: CLLocationDegrees!
    var userLocation: CLLocation!
    
    let locationManager = CLLocationManager()
    
    final let url = URL(string: "http://www.mocky.io/v2/5addd58b30000066154b28c9")
    
    @IBOutlet var avengersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        getJson()
        avengersTableView.tableFooterView = UIView()
        avengersTableView.reloadData()

    }
    
    func getJson(){
        guard let downloadURL = url else { return }
        URLSession.shared.dataTask(with: downloadURL) {data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else { return }
            do {
                let decoder = JSONDecoder()
                let downloadedAvengers = try decoder.decode(Avengers.self, from: data)
                self.avengers = downloadedAvengers.avengers
                DispatchQueue.main.async {
                    self.avengersTableView.reloadData()
                }
            } catch {
                    print("something wrong after downloading")
            }
            
        }.resume()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0]
        let long = userLocation.coordinate.longitude
        let lat = userLocation.coordinate.latitude
        
        self.userLat = lat
        self.userLong = long
        
        self.userLocation = CLLocation(latitude: self.userLat, longitude: self.userLong)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return avengers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AvengersCell")  as? AvengersCell
        

        //set image
        if let imageURL = URL(string: avengers[indexPath.row].imageURL){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data=data{
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell?.avengersPicture.image = image
                        cell?.avengersPicture.layer.cornerRadius = (cell?.avengersPicture.frame.height)!/2
                        cell?.avengersPicture.layer.masksToBounds = true
                    }
                }
            }
        }
        
        let avengerLat = CLLocationDegrees(avengers[indexPath.row].latitude)
        let avengerLong = CLLocationDegrees(avengers[indexPath.row].longitude)
        let avengersLoc = CLLocation(latitude: avengerLat, longitude: avengerLong)
        let distanceToAvenger = round(self.userLocation.distance(from: avengersLoc)/1000.0)
        
        cell?.avengersName.text = avengers[indexPath.row].name
        cell?.distance.text = "\(String(format: "%.1f", distanceToAvenger)) km"
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MapController") as? MapController
        
        vc?.selectedAvenger = avengers[indexPath.row].name
        vc?.latitude = avengers[indexPath.row].latitude
        vc?.longitude = avengers[indexPath.row].longitude
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
