//
//  DetailBarcodeViewController.swift
//  FinalProject-HajjApp
//
//  Created by Abeer Pr on 21/05/1442 AH.
//

import UIKit
import Firebase
import SDWebImage

class DetailBarcodeViewController: UIViewController {
    
    @IBOutlet var barcodeImage: UIImageView!
    
   static var barcodeImagePassed: UIImage!
    
   
    
    @IBAction func dismissButton(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        let blurEffect = UIBlurEffect(style: .regular)
        let visualEffect = UIVisualEffectView(effect: blurEffect)
        self.view.addSubview(visualEffect)
        self.view.sendSubviewToBack(visualEffect)
        visualEffect.frame = view.frame
        barcodeImagefunc()
    //    barcodeImage.image = DetailBarcodeViewController.barcodeImagePassed
     //   view.backgroundColor = .clear
    }
    
    func barcodeImagefunc() {
        if let userId = FirebaseConstants.userID?.uid {
            FirebaseConstants.users.getDocuments {  (snapshot, err) in
                if let err = err {
                    print("Error getting user's name: \(err)")
                } else {
                    
                    if (snapshot?.documents.first(where: { ($0["uid"] as? String) == userId })) != nil {
                        
                        self.barcodeImage.image = self.generateQRCode(from: userId)
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

}

//extension DetailBarcodeViewController: ImageSendingDelegateProtocol {
//
//    func sendBarcodeToDeatailViewViewController(barcodeImage: UIImage) {
//        self.barcodeImage.image = barcodeImage
//    }
//
//
//
//}
