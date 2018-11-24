//
//  MapController.swift
//  Avengers
//
//  Created by DEIK on 2018. 11. 22..
//  Copyright © 2018. Tamás Magyar. All rights reserved.
//

import UIKit
import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle:String?
    
    init(title:String, subtitle:String, location:CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = location
    }
}

class MapController: UIViewController, MKMapViewDelegate{

    var selectedAvenger = ""
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    let meters: Double = 300
    
    let annotation = MKPointAnnotation()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedAvenger
        
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        zoomOnMap(location: location)
        placeAnnotation(location: location)

        print("\(location.latitude) \(location.longitude)")
    }
    
    func zoomOnMap(location: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion.init(center: location, latitudinalMeters: meters, longitudinalMeters: meters)
        mapView.setRegion(region, animated: true)
    }
    
    func placeAnnotation(location: CLLocationCoordinate2D) {
        let customAnnotation = CustomAnnotation(title: selectedAvenger, subtitle: "\(selectedAvenger) itt van", location: location)
        mapView.addAnnotation(customAnnotation)
        mapView.delegate = self
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customannotation")
        annotationView.image = UIImage(named: "pin")
        annotationView.canShowCallout = true
        return annotationView
    }
}
