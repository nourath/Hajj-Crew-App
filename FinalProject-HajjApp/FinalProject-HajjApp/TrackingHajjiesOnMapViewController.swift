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
        fetchHajjCoordinates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchHajjCoordinates()

    }
    
    func searchFor(text: String) {
        
//        apiService.search(tag: text, success: { results in
//
//                print("Here are you pictures:\(results)")
//                DispatchQueue.main.async {
//                    self.showPinsOnMap(pins: results)
//                }
//
//            }) { error in
//
//            DispatchQueue.main.async {
//                // Show Alert when no photos found
//                let alert = UIAlertController(title: "No Photos Found",
//                                              message: "Could not find any photo with specified tag. Try another search query",
//                                              preferredStyle: UIAlertController.Style.alert)
//
//                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//
//                print("No Photos Found..")
//
//            }
//            switch error {
//
//            case FlickrSearchAPI.APIError.noPhotosFound:
//                break
//
//            default:
//                break
//            }
        }

    // Showing pin on map
    func showPinsOnMap(pins: [MKAnnotation]) {

        mapView.removeAnnotations(mapView.annotations)
        mapView.showAnnotations(pins, animated: true)
    }
    
    func fetchHajjCoordinates() {
        print("function")
        let userId = CrewQRCodeScannerViewController.uidFromQRCode
        FirebaseConstants.users.getDocuments { (snapshot, err) in
            if let err = err {
                print("Error getting user's name: \(err)")
            } else {
                print("fffff")

                if let currentUserDoc = snapshot?.documents.first(where: { ($0["uid"] as? String) == userId }) {
                    print("kkkkkk")

                    let getcurrentLocation = currentUserDoc["currentLocation"] as! GeoPoint
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
}

//MARK: - Search Bar Delegate

extension TrackingHajjiesOnMapViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let search = searchBar.text,
              search.isEmpty == false else {
            return
        }
        
        searchBar.resignFirstResponder()
        searchFor(text: search)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
    }
}
