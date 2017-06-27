//
//  CreateUsernameViewController.swift
//  Makestagram
//
//  Created by Portia Wang on 6/21/17.
//  Copyright © 2017 Portia Wang. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth

class CreateUsernameViewController : UIViewController{
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        //create user account here
        
        guard let firUser = Auth.auth().currentUser,
            let username = usernameTextField.text,
            !username.isEmpty else { return }
        
        //create user
        UserService.create(firUser, username: username) { (user) in
            guard let user = user else { return }
            
            User.setCurrent(user,writeToUserDefaults: true)
            
            let initialViewController = UIStoryboard.initialViewController(for: .main)
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()
        }
        
        //reference to database
        let userAttrs = ["username": username]
        let ref = Database.database().reference().child("users").child(firUser.uid)
        
        //set values
        ref.setValue(userAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return
            }
            
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let user = User(snapshot: snapshot)
                
                // handle newly created user here
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.layer.cornerRadius = 6
        
    }
    
    
    //access user in Userservice
    
    
}
