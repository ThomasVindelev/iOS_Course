//
//  ViewController.swift
//  MapDemo2020
//
//  Created by Thomas Vindelev on 20/03/2020.
//  Copyright © 2020 KEA. All rights reserved.
//

import UIKit
import FirebaseFirestore
import MapKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager() // will handle location (GPS, WiFi) updates
    
    @objc func longPressed(gestureRecognizer:UIGestureRecognizer) {
        let touchPoint = gestureRecognizer.location(in: map)
        let newCoordinates = map.convert(touchPoint, toCoordinateFrom: map)
        let annotation = MKPointAnnotation()
        annotation.coordinate = newCoordinates
        map.addAnnotation(annotation)
        let alert = UIAlertController(title: "Alert Title", message: "Alert Message", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Default placeholder text"
        }
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak alert] (_) in
            guard let textField = alert?.textFields?[0], let userText = textField.text else { return }
            MapDataAdapter.add(text: userText, coordinates: newCoordinates)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.showsUserLocation = true
        let uilgr = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressed))
        map.addGestureRecognizer(uilgr)
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // ask user to approve
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer // how precise do you want it?
//        locationManager.startUpdatingLocation() // start getting location data from device in a continuous stream
//        let marker = MKPointAnnotation() // create an empty marker
//        marker.title = "Go here" // a message on the marker
//        let location = CLLocationCoordinate2D(latitude: 55.7, longitude: 12.5) // Denmark in the world
//        marker.coordinate = location
//        map.addAnnotation(marker) // this is a marker (red), where the user can click for more info
//        let marker2 = MKPointAnnotation()
//        marker2.title = "Best pizzeria"
//        let location2 = CLLocationCoordinate2D(latitude: 55.6963, longitude: 12.5718)
//        marker2.coordinate = location2
//        map.addAnnotation(marker2)
//        let marker3 = MKPointAnnotation()
//        marker3.title = "Best venue"
//        let location3 = CLLocationCoordinate2D(latitude: 55.6577, longitude: 12.5891)
//        marker3.coordinate = location3
//        map.addAnnotation(marker3)
        FirebaseRepo.startListener(vc: self)
//        locationManager.stopUpdatingHeading()
    }
    
    
    @IBAction func startUpdate(_ sender: UIButton) {
    locationManager.startUpdatingLocation()
        map.showsUserLocation = true
    }
    

    @IBAction func stopUpdating(_ sender: UIButton) {
    locationManager.stopUpdatingLocation()
        map.showsUserLocation = false
    }
    
    func updateMarkers(snap: QuerySnapshot) { // raw data is passed in from Firebase
        let markers = MapDataAdapter.getMKAnnotationsFromData(snap: snap)
        print("updating markers...")
        // make a loop iterating through the markers list
        map.removeAnnotations(map.annotations)
        map.addAnnotations(markers)
    }

}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coord = locations.last?.coordinate {
            let region = MKCoordinateRegion(center: coord, latitudinalMeters: 300, longitudinalMeters: 300)
            map.setRegion(region, animated: true)
        }
    }
}
