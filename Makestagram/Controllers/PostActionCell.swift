//
//  PostActionCell.swift
//  Makestagram
//
//  Created by Portia Wang on 6/26/17.
//  Copyright © 2017 Portia Wang. All rights reserved.
//

import Foundation
import UIKit

protocol PostActionCellDelegate: class {
    func didTapLikeButton(_ likeButton: UIButton, on cell: PostActionCell)
}

class PostActionCell : UITableViewCell{
    
    //properties
    
    weak var delegate: PostActionCellDelegate?
    
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var timeAgoLabel: UILabel!
    static let height : CGFloat = 46
    
    //functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        delegate?.didTapLikeButton(sender as! UIButton, on: self)
    }
    
}
