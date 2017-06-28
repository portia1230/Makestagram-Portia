//
//  ViewController.swift
//  Makestagram
//
//  Created by Portia Wang on 6/21/17.
//  Copyright © 2017 Portia Wang. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseAuthUI
import FirebaseDatabase
import FirebaseFacebookAuthUI

typealias FIRUser = FirebaseAuth.User

class LoginViewController: UIViewController {
    
    //MARK : - Properties
    
    @IBOutlet weak var loginButton: UIButton!
  
    
    //MARK : - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //Mark: - IBActions
    
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        print ("login button tapped")
        
        guard let authUI = FUIAuth.defaultAuthUI()
            else { return }
        authUI.delegate = self
        
        let providers:[FUIAuthProvider] = [FUIFacebookAuth()]
        authUI.providers = providers
        
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
    }
    
}

    extension LoginViewController: FUIAuthDelegate {
        func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
            
            //report error
            if let error = error {
                assertionFailure("Error signing in: \(error.localizedDescription)")
            }
            
            // check to see whether user had been authorized
            guard let user = user
                else { return }
            
            //read from path to retrieve user data
           let userRef = Database.database().reference().child("users").child(user.uid)
            
            //redirect
            UserService.show(forUID: user.uid) { (user) in
                if let user = user {
                    //handle existing user
                    User.setCurrent(user, writeToUserDefaults: true)
                    
                    let initialViewController = UIStoryboard.initialViewController(for: .main)
                    self.view.window?.rootViewController = initialViewController
                    self.view.window?.makeKeyAndVisible()
                } else {
                    // handle new user
                    self.performSegue(withIdentifier: Constants.Segue.toCreateUsername, sender: self)
                }
            }
        }
        
    }
