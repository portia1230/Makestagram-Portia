//
//  PostHeaderCell.swift
//  Makestagram
//
//  Created by Portia Wang on 6/26/17.
//  Copyright © 2017 Portia Wang. All rights reserved.
//

import Foundation
import UIKit

class PostHeaderCell : UITableViewCell{
    //properties

    static let height : CGFloat = 54
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    //functions
    override func awakeFromNib(){
        super.awakeFromNib()
    }
    
 
    @IBAction func optionsButtonTapped(_ sender: Any) {
        print ("options button tapped")
    }
    
}
