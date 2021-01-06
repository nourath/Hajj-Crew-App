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
    
    var locationManager: CLLocationManager!
    static var latitude =  CLLocationDegrees()
    static var longitude =  CLLocationDegrees()

    override func viewDidLoad() {
        super.viewDidLoad()

//        locationManager = CLLocationManager()
//        locationManager.requestAlwaysAuthorization()
//        locationManager.delegate = self

        mapView.delegate = self
        
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.startUpdatingLocation()
//        }
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
                        let getCurrentLocation = document["currentLocation"] as! GeoPoint
                        let getName = document["fullName"] as! String
                        print(getCurrentLocation.latitude)
                        print(getCurrentLocation.longitude)
                        
                        self.mapView.removeAnnotations(self.mapView.annotations)
                        //getting current location
                        let location = CLLocationCoordinate2DMake(getCurrentLocation.latitude, getCurrentLocation.longitude)
                        print("hajj's location: \(location)")
                        let region = MKCoordinateRegion(center: location, latitudinalMeters: 500.0, longitudinalMeters: 700.0)
                        self.mapView.setRegion(region, animated: true)
                        // Drop a pin
                        let dropPin = MKPointAnnotation()
                        dropPin.coordinate = location
                        dropPin.title = getName
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
        mapView.removeAnnotations(mapView.annotations)
        searchFor(text: search)
        print("hh")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        mapView.removeAnnotations(mapView.annotations)
        searchBar.resignFirstResponder()
    }
}

