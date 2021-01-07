//
//  ChatViewController.swift
//  FinalProject-HajjApp
//
//  Created by Abeer Pr on 23/05/1442 AH.
//

import UIKit

class ChatViewController: UIViewController {
    
    @IBOutlet var sendButtonPressed: UIButton!
    
    
    @IBOutlet var messageTextFeild: UITextField!
    
    @IBOutlet var messageTableView: UITableView!
    
    @IBOutlet var senderID: UILabel!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    //    view.backgroundColor = .blue
        print("in chat vc")
//        messageTableView.delegate = self
//        messageTableView.dataSource = self
        
    }
    
//    func getMessageDesign(sender: Sender) {
//        switch sender {
//        case .me:
//            back
//        default:
//            <#code#>
//        }
//    }
}


//
//extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
    
    
    
//}
