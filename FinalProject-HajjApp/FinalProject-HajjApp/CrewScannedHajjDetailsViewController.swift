//
//  CrewScannedHajjDetailsViewController.swift
//  FinalProject-HajjApp
//
//  Created by Noura Althenayan on 05/01/2021.
//

import UIKit

class CrewScannedHajjDetailsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(CrewQRCodeScannerViewController.uidFromQRCode)
        fetchHajjDetails()
        // Do any additional setup after loading the view.
    }
    
    func fetchHajjDetails() {
        
         let userId = CrewQRCodeScannerViewController.uidFromQRCode
            FirebaseConstants.users.getDocuments { (snapshot, err) in
                if let err = err {
                    print("Error getting user's name: \(err)")
                } else {
                    
                    if let currentUserDoc = snapshot?.documents.first(where: { ($0["uid"] as? String) == userId }) {
                        let getName = currentUserDoc["fullName"] as! String
                        let getAge = currentUserDoc["age"] as! Int
                        let getBloodType = currentUserDoc["bloodType"] as! String
                        let getCampaign = currentUserDoc["campaign"] as! String
                        let getChronicDisseases = currentUserDoc["chronicDiseases"] as! String
                      //  let getcurrentLocation = currentUserDoc["fullName"] as! String
                        let getGender = currentUserDoc["gender"] as! String
                        let getMainLanguage = currentUserDoc["mainLanguage"] as! String
                        let getNationality = currentUserDoc["nationality"] as! String
                        let getOtherLanguages = currentUserDoc["otherLanguages"] as! String
                        let getPermitNumber = currentUserDoc["permitNumber"] as! String
                        let getPhoneNumber = currentUserDoc["phoneNumber"] as! Int
                        let getPicURL = currentUserDoc["picture"]
                        
                        print(getName)
                        print(getAge)
                        print(getBloodType)
                        print(getCampaign)
                        print(getChronicDisseases)
                        print(getGender)
                        print(getOtherLanguages)
                        print(getPhoneNumber)
                        print(getPicURL)

                    }
                }
            }
        
    }
}
