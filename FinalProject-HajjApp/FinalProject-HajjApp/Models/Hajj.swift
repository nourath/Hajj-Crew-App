//
//  Hajj.swift
//  FinalProject-HajjApp
//
//  Created by Noura Althenayan on 05/01/2021.
//

import UIKit
import CoreLocation
import Firebase

struct Hajj {
  
    var uid: String
    var key: String
    var name: String?
    var age: Int?
    var bloodType: String?
    var chronicDiseases: String?
    var currentLocation: CLLocationCoordinate2D?
    var enrolledCampaign: String?
    var gender: String?
    var mainLanguage: String?
    var nationality: String?
    var otherLanguages: String?
    var permitNumber: String?
    var picture: String?
    var phoneNumber: Int?
    var ref: DocumentReference?
    
    internal init(key:String = "",uid: String, name: String,age: Int, bloodType: String, chronicDiseases: String, currentLocation: CLLocationCoordinate2D, enroledCampaign: String, gender: String, mainLanguage: String, nationality: String, otherLanguages: String, permitNumber: String, picture: String, phoneNumber: Int) {
        self.key = key
        self.uid = uid
        self.name = name
        self.age = age
        self.bloodType = bloodType
        self.chronicDiseases = chronicDiseases
        self.currentLocation = currentLocation
        self.enrolledCampaign = enroledCampaign
        self.gender = gender
        self.mainLanguage = mainLanguage
        self.nationality = nationality
        self.otherLanguages = otherLanguages
        self.permitNumber = permitNumber
        self.picture = picture
        self.phoneNumber = phoneNumber
        self.ref = nil
    }
    
    
    init(snapshot: QueryDocumentSnapshot) {
        key = snapshot.documentID
        let snapshotValue = snapshot.data() as [String: AnyObject]
        uid = snapshotValue["uid"] as! String
        name = snapshotValue["fullName"] as? String
        age = snapshotValue["age"] as? Int
        bloodType = snapshotValue["bloodType"] as? String
        chronicDiseases = snapshotValue["chronicDisseases"] as? String
        uid = snapshotValue["uid"] as! String
        currentLocation = snapshotValue["currentLocation"] as? CLLocationCoordinate2D
        enrolledCampaign = snapshotValue["campaign"] as? String
        gender = snapshotValue["gender"] as? String
        mainLanguage = snapshotValue["mainLanguage"] as? String
        nationality = snapshotValue["nationality"] as? String
        otherLanguages = snapshotValue["otherLanguages"] as? String
        permitNumber = snapshotValue["permitNumber"] as? String
        picture = snapshotValue["picture"] as? String
        phoneNumber = snapshotValue["phoneNumber"] as? Int
        ref = snapshot.reference
    }
    
    func toAnyObject() -> Any {
        return [
            "fullName": name!,
            "age": age!,
            "bloodType": bloodType!,
            "chronicDisseases": chronicDiseases!,
            "currentLocation": currentLocation!,
            "campaign": enrolledCampaign!,
            "gender": gender!,
            "mainLanguage": mainLanguage!,
            "nationality": nationality!,
            "otherLanguages": otherLanguages!,
            "permitNumber": otherLanguages!,
            "picture": picture!,
            "phoneNumber": phoneNumber!,
            "uid": uid
        ]
    }
}


