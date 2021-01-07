//
//  Campaign.swift
//  FinalProject-HajjApp
//
//  Created by Noura Althenayan on 07/01/2021.
//

import UIKit
import CoreLocation
import Firebase

struct Campaign {
  
    var uid: String
    var key: String
    var name: String?
    var location: String?
    var coordinates: CLLocationCoordinate2D?
    var ref: DocumentReference?
    
    internal init(key:String = "",uid: String, name: String, location: String, coordinates: CLLocationCoordinate2D) {
        self.key = key
        self.uid = uid
        self.name = name
        self.location = location
        self.coordinates = coordinates
        self.ref = nil
    }
    
    
    init(snapshot: QueryDocumentSnapshot) {
        key = snapshot.documentID
        let snapshotValue = snapshot.data() as [String: AnyObject]
        uid = snapshotValue["uid"] as! String
        name = snapshotValue["name"] as? String
        location = snapshotValue["location"] as? String
        coordinates = snapshotValue["coordinates"] as? CLLocationCoordinate2D
        ref = snapshot.reference
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name!,
            "location": location!,
            "coordinates": coordinates!,
            "uid": uid
        ]
    }
}


