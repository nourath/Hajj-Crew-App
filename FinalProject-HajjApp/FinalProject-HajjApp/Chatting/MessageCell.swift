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
    
    //MARK: - Outlets
    
    @IBOutlet var messageContainerView: UIView!
    @IBOutlet var messageText: UILabel!
    
    //MARK: - Functions

    func getMessageDesign(sender: Sender) {

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
