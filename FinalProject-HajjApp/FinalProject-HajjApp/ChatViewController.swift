//
//  ChatViewController.swift
//  FinalProject-HajjApp
//
//  Created by Abeer Pr on 23/05/1442 AH.
//

import UIKit
import Firebase
import iOSUtilitiesSource

class ChatViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var sendButtonPressed: UIButton!
    
    
    @IBOutlet var messageTextFeild: UITextField!
    
    @IBOutlet var messageTableView: UITableView!
    
    @IBOutlet var senderID: UILabel!
    
    
    @IBOutlet var viewContainsTheMessage: UIView!
    
   
    
    var messages: [Message] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = UIColor.white
     //   iOSKeyboardShared.shared.keyBoardShowHide(view: self.view)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
   
        //    view.backgroundColor = .blue
        print("in chat vc")
        messageTableView.delegate = self
        messageTableView.dataSource = self
        messageTableView.separatorStyle = .none
        loadMessages()
        messageTextFeild.delegate = self
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))

        view.addGestureRecognizer(tap)

        view.isUserInteractionEnabled = true

     //   self.view.addSubview(view)

        // function which is triggered when handleTap is called
       
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//       // navigationController?.navigationItem.rightBarButtonItem(
//        let button1 = UIBarButtonItem(image: UIImage(named: "imagename"), style: .plain, target: self, action: #selector("backButtonTapped")) // action:#selector(Class.MethodName) for swift 3
//        self.navigationItem.rightBarButtonItem  = button1
//    }
//
//    @objc func backButtonTapped(_ sender: UIBarButtonItem) {
//
//    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        print("Hello World")
        messageTextFeild.endEditing(true)
        messageTextFeild.resignFirstResponder()
        view.endEditing(true)
        
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -150 // Move view 150 points upward
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0 // Move view to original position
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        messageTextFeild.endEditing(true)
        self.view.endEditing(true)
        messageTextFeild.resignFirstResponder()
        return false
        
    }
    override func resignFirstResponder() -> Bool {
        messageTextFeild.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
            animateViewMoving(up: true, moveValue: 100)
        }

        func textFieldDidEndEditing(_ textField: UITextField) {
            animateViewMoving(up: false, moveValue: 100)
        }
        func animateViewMoving (up:Bool, moveValue :CGFloat){
            let movementDuration:TimeInterval = 0.3
            let movement:CGFloat = ( up ? -moveValue : moveValue)
            UIView.beginAnimations( "animateView", context: nil)
            UIView.setAnimationBeginsFromCurrentState(true)
            UIView.setAnimationDuration(movementDuration )
            viewContainsTheMessage.frame = viewContainsTheMessage.frame.offsetBy(dx: 0, dy: movement)
            UIView.commitAnimations()
        }
    
    //pushing
    
    @IBAction func sendPressed(_ sender: UIButton) {
        messageTextFeild.endEditing(true)
        
        if let messageBody = messageTextFeild.text,
           let messageSender = FirebaseConstants.firebaseAuth.currentUser?.email {
            
            FirebaseConstants.db.collection("messages").addDocument(data: [
                "sender": messageSender,
                "body": messageBody,
                "date": Date().timeIntervalSince1970
            ]) { (error) in
                if let error = error {
                    print("error \(error)")
                } else {
                    DispatchQueue.main.async {
                        self.messageTextFeild.text = ""
                    }
                }
            }
        }
    }
    
    
//    @IBAction func viewdidTapped(_ sender: UITapGestureRecognizer) {
//
//     //   messageTextFeild.resignFirstResponder()
//        messageTextFeild.endEditing(true)
//        self.view.endEditing(true)
//    }
    

}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messageTableView.dequeueReusableCell(withIdentifier: "messageCell") as! MessageCell
        cell.messageText.text = messages[indexPath.row].body
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
        let message = messages[indexPath.row]
        if message.sender == FirebaseConstants.firebaseAuth.currentUser?.email {
            cell.getMessageDesign(sender: .me)
        } else {
            cell.getMessageDesign(sender: .crew)
        }
        return cell
    }
    
    func loadMessages() {
        FirebaseConstants.messages.order(by: "date")
            .addSnapshotListener { (snapShot, error) in
                self.messages = []
                if let error = error {
                    print(error)
                } else {
                    if let documents = snapShot?.documents {
                        for document in documents {
                            let data = document.data()
                            if let messageSender = data["sender"] as? String,
                               let messageBody = data["body"] as? String {
                                let newMessage = Message(sender: messageSender, body: messageBody)
                                
                                self.messages.append(newMessage)
                                
                                DispatchQueue.main.async {
                                    self.messageTableView.reloadData()
                                    let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                    
                                    self.messageTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                                }
                            }
                        }
                    }
                }
            }
    }
   
}

//extension ChatViewController: UITextFieldDelegate {
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        messageTextFeild.endEditing(true)
//        return true
//
//    }
//
//
//}
