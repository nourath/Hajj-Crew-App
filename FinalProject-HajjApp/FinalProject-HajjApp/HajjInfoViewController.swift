//
//  HajjInfoViewController.swift
//  FinalProject-HajjApp
//
//  Created by Abeer Pr on 21/05/1442 AH.
//

import UIKit
import Firebase
import SDWebImage

//protocol ImageSendingDelegateProtocol {
//    func sendBarcodeToDeatailViewViewController(barcodeImage: UIImage)
//}



class HajjInfoViewController: UIViewController {
    
    @IBOutlet var healthConditionView: DesignableView!
    @IBOutlet var additionalInfoView: UIView!
    @IBOutlet var campaignView: UIView!
    
    @IBOutlet var hajjPermitNumber: UILabel!
    
    @IBOutlet var barcodeView: UIImageView!
    
    @IBOutlet var hajjPic: UIImageView!
    
    @IBOutlet var hajjName: UILabel!
    
    @IBOutlet var hajjNationality: UILabel!
    
    @IBOutlet var hajjLanguage: UILabel!
    
    @IBOutlet var hajjAge: UILabel!
    @IBOutlet var hajjGender: UILabel!
    
    @IBOutlet var hajjBloodType: UILabel!
    
    @IBOutlet var campaignName: UILabel!
    
    @IBOutlet var campaignLocation: UILabel!
    
    @IBOutlet var hajjPhoneNumber: UILabel!
    
    @IBOutlet var hajjOtherLanguges: UILabel!
    
    @IBOutlet var hajjChronicDiseases: UILabel!
    

   
  
 
    
    var hajj: Hajj?
    
    override func viewDidLoad() {
        healthConditionView.roundCorners(corners: [.topLeft,.topRight], radius: 30)
        
        additionalInfoView.roundCorners(corners: [.topLeft,.topRight], radius: 30)
        campaignView.roundCorners(corners: [.topLeft,.topRight], radius: 30)
   
        fetchUserName()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(HajjInfoViewController.imageTapped(gesture:)))
        
        barcodeView.addGestureRecognizer(tapGesture)
        barcodeView.isUserInteractionEnabled = true
        

    }
    
    
    func fetchUserName() {
        
        if let userId = FirebaseConstants.userID?.uid {
            FirebaseConstants.users.getDocuments {  (snapshot, err) in
                if let err = err {
                    print("Error getting user's name: \(err)")
                } else {
                    
                    if let currentUserDoc = snapshot?.documents.first(where: { ($0["uid"] as? String) == userId }) {
                        
                        self.barcodeView.image = self.generateQRCode(from: userId)
                  
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
                        let getPicURL = currentUserDoc["picture"] as! String
                        
                        self.hajjName.text = getName
                        self.hajjPermitNumber.text = getPermitNumber
                        self.hajjNationality.text = getNationality
                        self.hajjLanguage.text = getMainLanguage
                        self.hajjAge.text = String(getAge)
                        self.hajjPermitNumber.text = getPermitNumber
                        self.hajjGender.text = getGender
                        self.hajjBloodType.text = getBloodType
                        self.campaignName.text = getCampaign
                       // self.campaignLocation.text =
                        self.hajjPhoneNumber.text = String(getPhoneNumber)
                        self.hajjOtherLanguges.text = getOtherLanguages
                        self.hajjChronicDiseases.text = getChronicDisseases

                      //  print(getName)
                    }
                }
            }
        }
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        
        let data = string.data(using: String.Encoding.utf8)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                
                let colorParameters = [
                    "inputColor0": CIColor(color: UIColor.white), // Foreground
                    "inputColor1": CIColor(color: UIColor.black) // Background
                ]
                let colored = output.applyingFilter("CIFalseColor", parameters: colorParameters)

                return UIImage(ciImage: colored)
            }
        }
        
        return nil
    }
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
         // if the tapped view is a UIImageView then set it to imageview
         if (gesture.view as? UIImageView) != nil {
             print("Image Tapped")
            
            // Blur Visual Effect
            //            let blurEffect = UIBlurEffect(style: .regular)
            //            let visualEffect = UIVisualEffectView(effect: blurEffect)
            //            self.view.addSubview(visualEffect)
            //            self.view.sendSubviewToBack(visualEffect)
            //            visualEffect.frame = view.frame
            
            let storyboard = UIStoryboard(name: "HajjInfoStoryboard", bundle: nil)
            let detailBarcodeVC =  storyboard.instantiateViewController(identifier: "Barcode")
            detailBarcodeVC.modalPresentationStyle = .overFullScreen
            detailBarcodeVC.view.backgroundColor = .clear
          //  DetailBarcodeViewController.barcodeImagePassed = hajjPic.image!
           
          //  dVC.barcodeImage.image = hajjPic.image
            
            present(detailBarcodeVC, animated: true)
            
            
         }
    }
    
}



