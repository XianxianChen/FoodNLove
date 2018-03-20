//
//  FirebaseService.swift
//  Food+Love
//
//  Created by C4Q on 3/16/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase


struct FirebaseService {
    static let manager = FirebaseService()
    private init() {}
    
    func loginUser(email: String, password: String, completionHandler: @escaping  (User?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                completionHandler(nil, error)
            }
            if let user = user {
                completionHandler(user, nil)
            }
        }
    }
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Signing out error: \(error)")
        }
    }
    func creatNewAccoutUsingEmail(name: String, email: String, password: String, completionHandler: @escaping (User?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                //  print("create new account error: \(error)")
                completionHandler(nil, error)
            }
            if let user = user {
                user.sendEmailVerification(completion: { (error) in
                    if let error = error {
                      print("failing sending password reset email error: \(error.localizedDescription)")
                    }
                })
                let userProfileRef = Database.database().reference().child("users")
               // let userProfile = UserProfile(email: email, userID: user.uid)
                let userProfile = UserProfile(name: name, email: email, userID: user.uid, dob: "", address: "", city: "", zipcode: 10001, foodPreference: [], imageUrl: "", videoUrl: "")
                userProfileRef.childByAutoId().setValue(userProfile.toJson())
                completionHandler(user, nil)
            }
        }
    }
    
    
    
    
    
    
    
}
