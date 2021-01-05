//
//  FirebaseConstants.swift
//  FinalProject-HajjApp
//
//  Created by Noura Althenayan on 05/01/2021.
//

import Foundation
import Firebase
import FirebaseAuth

class FirebaseConstants {
    
    static var firebaseAuth = Auth.auth()
    static var db = Firestore.firestore()
    static var userID = Auth.auth().currentUser
    
    static var users = Firestore.firestore().collection("hajjies")
    static var picStorageRef = Storage.storage().reference().child("hajjies-pictures")
    
}
