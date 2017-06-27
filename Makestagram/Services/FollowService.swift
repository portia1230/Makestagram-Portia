//
//  FollowService.swift
//  
//
//  Created by Portia Wang on 6/26/17.
//
//

import Foundation
import FirebaseDatabase

struct FollowService{
    
    private static func followUser(_ user: User, forCurrentUserWithSuccess success: @escaping (Bool)-> Void){
        let currentUID = User.current.uid
        let followData = ["followers\(user.uid)/\(currentUID)" : true, "following/\(currentUID)/\(user.uid) : true" : true]
        let ref = Database.database().reference()
        ref.updateChildValues(followData) { (error, _) in
            if let error = error {
                assertionFailure(error.localizedDescription)
            }
            success(error == nil)
        }
    }
    
    private static func unfollowUser (_ user: User, forCurrentUserWithSuccess success: @escaping (Bool)-> Void){
        let currentUID = User.current.uid
        let followData = ["followers\(user.uid)/\(currentUID)": NSNull(), "following/\(currentUID)/\(user.uid)" : NSNull()]
        let ref = Database.database().reference()
        ref.updateChildValues(followData){ (error, _) in
            if let error = error {
                assertionFailure(error.localizedDescription)
            }
            success(error == nil )
        }
    }
    
    static func setIsFollowing(_ isFollowing: Bool, fromCurrentUserTo followee: User, success: @escaping (Bool)->Void){
        if isFollowing{
            followUser(followee, forCurrentUserWithSuccess: success)
        }else{
            unfollowUser(followee, forCurrentUserWithSuccess: success)
        }
    }
    
    static func isUserFollowed(_ user: User, byCurrentUserWithCompletion completion: @escaping (Bool) -> Void) {
        let currentUID = User.current.uid
        let ref = Database.database().reference()
        
        ref.queryEqual(toValue: nil, childKey: currentUID).observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? [String : Bool] {
                completion(true)
            } else {
                completion(false)
            }
        })
    }
}
