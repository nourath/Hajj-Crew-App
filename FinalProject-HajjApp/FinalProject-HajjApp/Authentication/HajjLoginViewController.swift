//
//  HajjLoginViewController.swift
//  FinalProject-HajjApp
//
//  Created by Noura Althenayan on 05/01/2021.
//

import UIKit

class HajjLoginViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginButtonTapped(_ sender: DesignableButton) {
        print(validateFields())
    }
    
    // MARK: - User Authentication Steps
    /*
     Fields authentication and validation steps:
     1. Checking if fields are filled or empty.
        1.1 Call function `validateFields()`
     
     2. Checking if user credentials are matching.
        2.1 Call function `firebaseAuth()`
        2.2 If all conditions were true, then sign the user in.
     
     3. Transition to Home Screen.
        3.1 Call function `transtionToHome()`
     */
    
    func validateFields() -> String {
        
        //check if filled or empty
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            // create the alert
            let alert = UIAlertController(title: "Empty Fields", message: "Please fill out all the fields.", preferredStyle: UIAlertController.Style.alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
            return "Please fill out all the fields."
            
        } else {
                        
            firebaseAuth()
            return ""
        }
    }

    func firebaseAuth() {
        
        //clean version of text fields
        let email = emailTextField!.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        //Signing in
        FirebaseConstants.firebaseAuth.signIn(withEmail: email, password: password) { (result, error) in

            if error != nil {
                print(error!.localizedDescription)
                // create the alert
                let alert = UIAlertController(title: "Error", message: "\(error!.localizedDescription)", preferredStyle: UIAlertController.Style.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
        }
            else {
                self.transitionToMainTabScreen()
            }
        }

    }

    func transitionToMainTabScreen() {
        
        let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
        let mainTabVC =  storyboard.instantiateViewController(identifier: "tabBar")
         
         view.window?.rootViewController = mainTabVC
         view.window?.makeKeyAndVisible()
         
     }

}
