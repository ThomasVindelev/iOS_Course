//
//  ViewController.swift
//  FirebaseLogin
//
//  Created by Thomas Vindelev on 03/04/2020.
//  Copyright © 2020 KEA. All rights reserved.
//

import UIKit
import FirebaseAuth
import FacebookLogin
import FacebookCore

class ViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var greetingField: UILabel!
    
    @IBOutlet weak var signupBtn: UIButton!
    
    @IBOutlet weak var signinBtn: UIButton!
    
    var firebaseManager:FirebaseManager?
    
    var auth = Auth.auth() // Firebase authentication class.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseManager = FirebaseManager(parentVC:self) // will enable firebasemanager to update GUI
    }

    @IBAction func signBtnsPressed(_ sender: UIButton) {
        if let email = emailField.text, let pwd = passwordField.text {
            if email.count > 5 && pwd.count > 5 {
                if sender == signupBtn {
                    firebaseManager?.signUp(email: email, password: pwd)
                } else {
                    firebaseManager?.signIn(email: email, password: pwd)
                }
            }
        }
    }
    
    @IBAction func signoutBtnPressed(_ sender: UIButton) {
        firebaseManager?.signOut()
    }
    
    
    
    @IBAction func facebookLoginPressed(_ sender: UIButton) {
        print("facebook login")
        let manager = LoginManager()
        manager.logIn(permissions: [.publicProfile], viewController: self) { (result) in
            print("Logged in to Facebook")
            switch result {
            case .cancelled :
                print("Login was cancelled")
                break
            case .failed(let error) :
                print("Login failed \(error.localizedDescription)")
                break
            case let .success(granted: _, declined: _, token: token) :
                print("Success logging in to Facebook \(token.userID)")
                self.firebaseManager?.signInUsingFacebook(tokenString: token.tokenString)
            }
        }
    }
    
    @IBAction func loadFacebookDataPressed(_ sender: UIButton) {
        if let tokenString = AccessToken.current?.tokenString {
            let graphRequest = GraphRequest(graphPath: "/me",
                                            parameters: ["fields":"id, name, email"],
                                            tokenString: tokenString,
                                            version: Settings.defaultGraphAPIVersion,
                                            httpMethod: .get)
            let connection = GraphRequestConnection()
            connection.add(graphRequest) { (connection, result, error) in
                if error == nil, let res = result {
                    print("Got data from Facebook")
                    let dict = res as! [String:Any]
                    let name = dict["name"] as! String
                    let email = dict["email"] as? String
                    print("Got \(name) \(email) from Facebook")
                } else {
                    print("Error getting data from Facebook \(error.debugDescription)")
                }
            }
            connection.start()
        }
        
    }
}
