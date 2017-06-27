//
//  FindFriendsViewController.swift
//  Makestagram
//
//  Created by Portia Wang on 6/22/17.
//  Copyright © 2017 Portia Wang. All rights reserved.
//

import UIKit

class FindFriendsViewController: UIViewController{
    
    //properties
    
    var users = [User]()
    
    //subviews
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //VC lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 60
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        UserService.usersExcludingCurrentUser { [unowned self] (users) in
            
            self.users = users
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
    
}

//Find Friends Cell delegate

extension FindFriendsViewController: FindFriendsCellDelegate {
    
    //did tap follow button
    func didTapFollowButton(_ followButton: UIButton, on cell: FindFriendsCell) {
        
        
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        followButton.isUserInteractionEnabled = false
        let followee = users[indexPath.row]
        
        FollowService.setIsFollowing(!followee.isFollowed, fromCurrentUserTo: followee) { (success) in
            defer {
                followButton.isUserInteractionEnabled = true
            }
                
            guard success else { return }
            
            followee.isFollowed = !followee.isFollowed
            self.tableView.reloadRows(at: [indexPath], with: .none)
            }
    }
}


// MARK: - UITableViewDataSource

extension FindFriendsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FindFriendsCell") as! FindFriendsCell
      
        cell.delegate = self
        configure(cell: cell, atIndexPath: indexPath)
        
        return cell
    }
    
    func configure(cell: FindFriendsCell, atIndexPath indexPath: IndexPath) {
        let user = users[indexPath.row]
        
        cell.usernameLabel.text = user.username
        cell.followButton.isSelected = user.isFollowed
    }
}
