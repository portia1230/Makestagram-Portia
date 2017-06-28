//
//  ProfileHeaderView.swift
//  Makestagram
//
//  Created by Portia Wang on 6/28/17.
//  Copyright © 2017 Portia Wang. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

protocol ProfileHeaderViewDelegate: class{
    func didTapSettingsButton(_ button: UIButton, on headerView: ProfileHeaderView)
    
}

class ProfileHeaderView : UICollectionReusableView{
    
    
    //properties
    
    weak var delegate: ProfileHeaderViewDelegate?
    @IBOutlet weak var postCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var settingsButton: UIButton!
 
    
    //function
    
    override func awakeFromNib() {
        super.awakeFromNib()
        settingsButton.layer.cornerRadius = 6
        settingsButton.layer.borderColor = UIColor.lightGray.cgColor
        settingsButton.layer.borderWidth = 1
    }
    
    
    @IBAction func settingButtonTapped(_ sender: UIButton) {
        delegate?.didTapSettingsButton(sender, on: self)
    }
    
}
