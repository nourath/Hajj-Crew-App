//
//  TrackingHajjiesOnMapViewController.swift
//  FinalProject-HajjApp
//
//  Created by Noura Althenayan on 06/01/2021.
//

import UIKit
import MapKit
import CoreLocation
import Firebase

class TrackingHajjiesOnMapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
    }

    
    func searchFor(text: String) {
        //"H42-C1-001"

        FirebaseConstants.users.whereField("permitNumber", isEqualTo: text)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("hhhh \(document.documentID) => \(document.data())")
//                        print(document.data().index(forKey: "currentLocation"))
                        let getcurrentLocation = document["currentLocation"] as! GeoPoint
                        print(getcurrentLocation.latitude)
                        print(getcurrentLocation.longitude)
                        
                        //getting current location
                        let location = CLLocationCoordinate2DMake(getcurrentLocation.latitude, getcurrentLocation.longitude)
                        print("hajj's location: \(location)")
                        let region = MKCoordinateRegion(center: location, latitudinalMeters: 500.0, longitudinalMeters: 700.0)
                        self.mapView.setRegion(region, animated: true)
                        // Drop a pin
                        let dropPin = MKPointAnnotation()
                        dropPin.coordinate = location
                        dropPin.title = "موقع الحاج -رقم تصريح كذت-"
                        self.mapView.addAnnotation(dropPin)
                        
                    }
                }
            }
        
        
    }
    
    // Showing pin on map
    func showPinsOnMap(pins: [MKAnnotation]) {

        mapView.removeAnnotations(mapView.annotations)
        mapView.showAnnotations(pins, animated: true)
    }
    
//    func fetchHajjCoordinates() {
//        print("function")
//        let userId = CrewQRCodeScannerViewController.uidFromQRCode
//        FirebaseConstants.users.getDocuments { (snapshot, err) in
//            if let err = err {
//                print("Error getting user's name: \(err)")
//            } else {
//                print("fffff")
//
//                if let currentUserDoc = snapshot?.documents.first(where: { ($0["uid"] as? String) == userId }) {
//                    print("kkkkkk")
//
//                    let getcurrentLocation = currentUserDoc["currentLocation"] as! GeoPoint
//                    let location = CLLocationCoordinate2DMake(getcurrentLocation.latitude, getcurrentLocation.longitude)
//                    print("hajj's location: \(location)")
//                    let region = MKCoordinateRegion(center: location, latitudinalMeters: 500.0, longitudinalMeters: 700.0)
//                    self.mapView.setRegion(region, animated: true)
//                    // Drop a pin
//                    let dropPin = MKPointAnnotation()
//                    dropPin.coordinate = location
//                    dropPin.title = "موقع الحاج -رقم تصريح كذت-"
//                    self.mapView.addAnnotation(dropPin)
//                }
//            }
//        }
//    }
}

//MARK: - Search Bar Delegate

extension TrackingHajjiesOnMapViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let search = searchBar.text,
              search.isEmpty == false else {
            return
        }
        print(search)
        searchBar.resignFirstResponder()
        searchFor(text: search)
        print("hh")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
    }
}
