//
//  HajjGeoPoint.swift
//  FinalProject-HajjApp
//
//  Created by Noura Althenayan on 06/01/2021.
//

import Foundation
import MapKit

//MARK: - Searched Photo Object

class HajjGeoPoint: NSObject, MKAnnotation {
   
    let title: String?
    let longitude: Double
    let latitude: Double
    
    var iconLink: String
    var fullPhotoLink: String
    
    // Photo Coordinates
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    // JSON Initializer
    init?(json: [String: Any]) {
        
        guard let lat = json["latitude"] as? String,
              let doubleLat = Double(lat),
              let lon = json["longitude"] as? String,
              let doubleLon = Double(lon),
              let icon = json["url_s"] as? String,
              let fullPhoto = json["url_l"] as? String
            
        else {
                return nil
        }
        self.longitude = doubleLon
        self.latitude = doubleLat
        self.iconLink = icon
        self.fullPhotoLink = fullPhoto
        self.title = json["title"] as? String
    }

}
