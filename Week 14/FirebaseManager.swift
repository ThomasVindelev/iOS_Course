//
//  FirebaseManager.swift
//  FirebaseLogin
//
//  Created by Thomas Vindelev on 03/04/2020.
//  Copyright © 2020 KEA. All rights reserved.
//

import Foundation
import FirebaseAuth

class FirebaseManager {
    
    let auth = Auth.auth()
    let parentVC:ViewController
    
    init(parentVC:ViewController) {
        self.parentVC = parentVC
        auth.addIDTokenDidChangeListener { (auth, user) in
            if user != nil {
                print("User is logged in: \(user)")
                parentVC.greetingField.text = "Hello there!"
            } else {
                print("User is logged out")
                parentVC.greetingField.text = ""
            }
        }
    }
    
    func signUp(email:String, password:String) {
        auth.createUser(withEmail: email, password: password) { (result, error) in
            if error == nil { // success
                print("Successfully created user in Firebase \(result)")
            } else {
                print("Failed to create user \(error.debugDescription)")
            }
        }
    }
    
    func signIn(email:String, password:String) {
        auth.signIn(withEmail: email, password: password) { (result, error) in
            if error == nil { // success
                print("Successfully signed in to Firebase \(result)")
                // call parentVC to display something, such as parentVC.showPanel()
            } else {
                print("Failed to sign in \(error.debugDescription)")
            }
        }
    }
    
    func signInUsingFacebook(tokenString:String) {
        let credential = FacebookAuthProvider.credential(withAccessToken: tokenString)
        auth.signIn(with: credential) { (result, error) in
            if error == nil {
                print("Logged in to Firebase using Facebook \(result?.description)")
            } else {
                print("Failed to log in to Firebase using Facebook \(error.debugDescription)")
            }
        }
    }
    
    func signOut() {
        do {
            try auth.signOut()
        } catch let error {
            print("error signing out \(error.localizedDescription)")
        }
        print("Signed out")
    }
    
}
