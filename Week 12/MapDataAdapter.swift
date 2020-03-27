//
//  MapDataAdapter.swift
//  MapDemo2020
//
//  Created by Thomas Vindelev on 20/03/2020.
//  Copyright © 2020 KEA. All rights reserved.
//

import Foundation
import FirebaseFirestore
import MapKit

class MapDataAdapter {
    
    private static let db = Firestore.firestore() // gets the firebase instance
    
    private static let path = "locations" // points to the collection in the Firebase database
    
    static func getMKAnnotationsFromData(snap:QuerySnapshot) -> [MKPointAnnotation] {
        var markers = [MKPointAnnotation]() // create an empty list
        for doc in snap.documents {
            print("recieved data")
            let map = doc.data() // the data delivered is stored in a map with key and value
            let text = map["text"] as! String
            let geoPoint = map["coordinates"] as! GeoPoint
            let mkAnnotation = MKPointAnnotation()
            mkAnnotation.title = text
            let coordinate = CLLocationCoordinate2D(latitude: geoPoint.latitude, longitude: geoPoint.longitude)
            mkAnnotation.coordinate = coordinate
            markers.append(mkAnnotation)
        }
        return markers
    }
    
    static func add(text:String, coordinates:CLLocationCoordinate2D) {
        var map = [String:Any]()
        map["text"] = text
        let geoPoint = GeoPoint(latitude: coordinates.latitude, longitude: coordinates.longitude)
        map["coordinates"] = geoPoint
        db.collection("locations").addDocument(data: map)
    }
    
}
