//
//  FirebaseRepo.swift
//  MapDemo2020
//
//  Created by Thomas Vindelev on 20/03/2020.
//  Copyright © 2020 KEA. All rights reserved.
//

import Foundation
import FirebaseFirestore

class FirebaseRepo {
    
    private static let db = Firestore.firestore() // gets the firebase instance
    
    private static let path = "locations" // points to the collection in the Firebase database
    
    static func startListener(vc: ViewController) {
        print("listener started")
        db.collection(path).addSnapshotListener { (snap, error) in
            if error != nil { // check for error, and return if true
                return
            }
            if let snap = snap { // this is a way of unwrapping the snap optional
                vc.updateMarkers(snap: snap)
            }
        }
    }
}
