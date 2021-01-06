//
//  CrewScannedHajjDetailsViewController.swift
//  FinalProject-HajjApp
//
//  Created by Noura Althenayan on 05/01/2021.
//

import UIKit
import CoreLocation
import Firebase
import MLKitTranslate


class CrewScannedHajjDetailsViewController: UIViewController {
    
    @IBOutlet var permitNumberLabel: DesignableLabel!
    @IBOutlet var profilePicture: UIImageView!
    @IBOutlet var fullNameLabel: UILabel!
    @IBOutlet var nationalityLabel: UILabel!
    @IBOutlet var languageLabel: UILabel!
    @IBOutlet var bloodTypeLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var ageLabel: UILabel!
    @IBOutlet var campaignNameLabel: UILabel!
    @IBOutlet var campaignDestinationLabel: UILabel!
    @IBOutlet var phoneNumberLabel: UILabel!
    @IBOutlet var otherLanguagesLabel: UILabel!
    @IBOutlet var chronicDiseasesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(CrewQRCodeScannerViewController.uidFromQRCode)
        blurryEffectOnBG()
        fetchHajjDetails()
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
                        let getGender = currentUserDoc["gender"] as! String
                        let getMainLanguage = currentUserDoc["mainLanguage"] as! String
                        let getNationality = currentUserDoc["nationality"] as! String
                        let getOtherLanguages = currentUserDoc["otherLanguages"] as! String
                        let getPermitNumber = currentUserDoc["permitNumber"] as! String
                        let getPhoneNumber = currentUserDoc["phoneNumber"] as! Int
                        let getPicURL = currentUserDoc["picture"]
                        let getcurrentLocation = currentUserDoc["currentLocation"] as! GeoPoint
                        
                        // Create an English-Arabic translator:
                        let options = TranslatorOptions(sourceLanguage: .english, targetLanguage: .arabic)
                        let englishArabicTranslator = Translator.translator(options: options)
                        let conditions = ModelDownloadConditions(
                            allowsCellularAccess: false,
                            allowsBackgroundDownloading: true
                        )
                        
                        englishArabicTranslator.downloadModelIfNeeded(with: conditions) { error in
                            guard error == nil else { return }
                            // Model downloaded successfully. Okay to start translating.
                        }
                        
                        DispatchQueue.main.async { [self] in
                            
                            permitNumberLabel.text = getPermitNumber
                            bloodTypeLabel.text = getBloodType
                            campaignNameLabel.text = getCampaign.uppercased()
                            phoneNumberLabel.text = String(getPhoneNumber)
                            ageLabel.text = String(getAge) + " عام "

                            englishArabicTranslator.translate(getName) { translatedText, error in
                                guard error == nil, let translatedText = translatedText else { return }
                                fullNameLabel.text = translatedText
                                print(translatedText)
                            }
                            englishArabicTranslator.translate(getNationality) { translatedText, error in
                                guard error == nil, let translatedText = translatedText else { return }
                                nationalityLabel.text = translatedText
                                print(translatedText)
                            }
                            englishArabicTranslator.translate(getMainLanguage) { translatedText, error in
                                guard error == nil, let translatedText = translatedText else { return }
                                languageLabel.text = translatedText
                                print(translatedText)
                            }
                            englishArabicTranslator.translate(getGender) { translatedText, error in
                                guard error == nil, let translatedText = translatedText else { return }
                                genderLabel.text = translatedText
                                print(translatedText)
                            }
                            englishArabicTranslator.translate(getOtherLanguages) { translatedText, error in
                                guard error == nil, let translatedText = translatedText else { return }
                                otherLanguagesLabel.text = " لغات أخرى: " + translatedText
                                print(translatedText)
                            }
                            englishArabicTranslator.translate(getChronicDisseases) { translatedText, error in
                                guard error == nil, let translatedText = translatedText else { return }
                                chronicDiseasesLabel.text = translatedText
                                print(translatedText)
                            }


                        }
//                        DispatchQueue.main.async { [self] in
//                            let translatedName = "\(translateToArabic(text: getName))"
//
//                            permitNumberLabel.text = getPermitNumber
//                            fullNameLabel.text = translatedName
//                            nationalityLabel.text = "\(translateToArabic(text: getNationality))"
//                            languageLabel.text = translateToArabic(text: getMainLanguage)
//                            bloodTypeLabel.text = getBloodType
//                            ageLabel.text = String(getAge) + " عام "
//                            genderLabel.text = translateToArabic(text: getGender)
//                            campaignNameLabel.text = getCampaign
//                            phoneNumberLabel.text = String(getPhoneNumber)
//                            otherLanguagesLabel.text = " لغات أخرى: " + translateToArabic(text: getOtherLanguages)
//                            chronicDiseasesLabel.text = translateToArabic(text: getChronicDisseases)
//
//                        }
                        
                        print(getName)
                        print(getAge)
                        print(getBloodType)
                        print(getCampaign)
                        print(getChronicDisseases)
                        print(getGender)
                        print(getOtherLanguages)
                        print(getPhoneNumber)
                        print(getPicURL)
                        print(getMainLanguage)
                        print(getNationality)
                        print(getPermitNumber)
                        print(getcurrentLocation)
                        print(getcurrentLocation.latitude)
                        print(getcurrentLocation.longitude)

                    }
                }
            }
        
    }
    
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func blurryEffectOnBG() {
        let blurEffect = UIBlurEffect(style: .regular)
        let visualEffect = UIVisualEffectView(effect: blurEffect)
        self.view.addSubview(visualEffect)
        self.view.sendSubviewToBack(visualEffect)
        visualEffect.frame = view.frame
    }

    
    func translateToArabic(text: String) {
        
//        var arabicText = ""

        // Create an English-Arabic translator:
        let options = TranslatorOptions(sourceLanguage: .english, targetLanguage: .arabic)
        let englishArabicTranslator = Translator.translator(options: options)
        let conditions = ModelDownloadConditions(
            allowsCellularAccess: false,
            allowsBackgroundDownloading: true
        )

        englishArabicTranslator.downloadModelIfNeeded(with: conditions) { error in
            guard error == nil else { return }
            // Model downloaded successfully. Okay to start translating.
        }

        englishArabicTranslator.translate(text) { translatedText, error in
            guard error == nil, let translatedText = translatedText else { return }

            // Translation succeeded.
//            print("\(text) in arabic is: \(translatedText)")
//            arabicText = translatedText
//            print("lll " + arabicText)
            print(translatedText)

//            return translatedText
        }
//        print("lll " + arabicText)
//        return arabicText
    }
}
