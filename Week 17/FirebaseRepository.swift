//
//  FirebaseRepository.swift
//  SensorApp
//
//  Created by Thomas Vindelev on 28/04/2020.
//  Copyright © 2020 KEA. All rights reserved.
//

import Foundation
import FirebaseFirestore

class FirebaseRepository {
    
    private static let db = Firestore.firestore()
    
    private static let path = "info"
    
    static func add(distance: String, steps: String, comment: String) {
        var map = [String:String]()
        map["distance"] = distance
        map["steps"] = steps
        map["comment"] = comment
        db.collection(path).addDocument(data: map)
    }
    
}
