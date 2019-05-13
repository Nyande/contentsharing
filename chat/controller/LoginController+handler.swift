
//  LoginController+handler.swift
//  chat

//  Created by K2 Paul on 21/04/2019.
//  Copyright © 2019 K2 Paul. All rights reserved.


import UIKit
import Firebase


extension loginController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    fileprivate func registerUserIntoDatabaseWithUID(_ uid: String, values: [String: AnyObject]) {
        let ref = Database.database().reference()
        let usersReference = ref.child("users").child(uid)
        
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if let err = err {
                print(err)
                return
            }
            
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    
}

