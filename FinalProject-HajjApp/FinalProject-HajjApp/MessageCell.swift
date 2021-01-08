//
//  MessageCell.swift
//  FinalProject-HajjApp
//
//  Created by Abeer Pr on 24/05/1442 AH.
//

import UIKit

enum Sender {
    case me
    case crew
}

class MessageCell: UITableViewCell {
    
    @IBOutlet var messageContainerView: UIView!
    @IBOutlet var messageText: UILabel!
    func getMessageDesign(sender: Sender){
      //  messageText.textColor = #colorLiteral(red: 0.02360551991, green: 0.2150389254, blue: 0.2304697633, alpha: 1)
        let backgroundColor: UIColor?
        
        switch sender {
        case .me:
            
            backgroundColor =  #colorLiteral(red: 0.2350148857, green: 0.3928009868, blue: 0.3512820601, alpha: 1)
            messageText.textColor = UIColor.white
            messageContainerView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
            messageText.textAlignment = .right
            
        case .crew:
            backgroundColor =  UIColor.lightGray
            messageText.textColor = #colorLiteral(red: 0.2350148857, green: 0.3928009868, blue: 0.3512820601, alpha: 1)
            messageContainerView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner,.layerMaxXMinYCorner]
            messageText.textAlignment = .left
            
        default:
            break
            
        }
        messageContainerView.backgroundColor = backgroundColor
        messageContainerView.layer.cornerRadius = messageContainerView.frame.size.height/2.5
        messageContainerView.layer.shadowOpacity = 0.1
    }
}
