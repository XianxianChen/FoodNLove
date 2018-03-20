//  AuthUserService.swift
//  POSTR
//  Created by Lisa J on 2/1/18.
//  Copyright © 2018 On-The-Line. All rights reserved.


import Foundation
import Firebase

@objc protocol AuthUserServiceDelegate: class {
    
    //create user delegate protocols
    @objc optional func didFailCreatingUser(_ userService: AuthUserService, error: Error)
    @objc optional func didCreateUser(_ userService: AuthUserService, user: User)
    
    //sign out delegate protocols
    @objc optional func didFailSigningOut(_ userService: AuthUserService, error: Error)
    @objc optional func didSignOut(_ userService: AuthUserService)
    
    //sign in delegate protocols
    @objc optional func didFailSignIn(_ userService: AuthUserService, error: Error)
    @objc optional func didSignIn(_ userService: AuthUserService, user: User)
    @objc optional func didFailVerifyEmail()
}


class AuthUserService: NSObject {
    weak var delegate: AuthUserServiceDelegate?
    static let manager = AuthUserService()
    private override init() {}
    
    func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
    
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
            self.delegate?.didFailSigningOut?(self, error: error)
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
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = name
                changeRequest.commitChanges(completion: { (error) in
                    if let changeError = error {
                        print("commit change request error: \(changeError)")
                    }
                })
                let userProfileRef = Database.database().reference().child("users")
                // let userProfile = UserProfile(email: email, userID: user.uid)
                let userProfile = UserProfile(name: name, email: email, userId: user.uid, gender: "", genderPreference: "", bio: "", dob: "", address: "", city: "", zipcode: 10001, foodPreference: [:], favoriteRes: nil, traits: [:], profileImageUrl: "", profileVideoUrl: "")
                userProfileRef.childByAutoId().setValue(userProfile.toJson())
                completionHandler(user, nil)
            }
        }
    }
    
    func resetPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
            print("failing sending password reset email error: \(error.localizedDescription)")
            }
            
        }
        
    }
    
    
}

