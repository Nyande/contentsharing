//
//  ViewController.swift
//  chat
//
//  Created by K2 Paul on 31/03/2019.
//  Copyright © 2019 K2 Paul. All rights reserved.
//

import UIKit
import Firebase

class MessagesController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        //Setting the login button at the topleft hand corner
        navigationItem.leftBarButtonItem=UIBarButtonItem(title:"Logout", style:.plain, target:self,action:#selector(handlelogout))
        
        let image=UIImage(named: "meso")
        navigationItem.rightBarButtonItem=UIBarButtonItem(image: image,style:.plain, target: self, action:#selector(handleNewMessage))
        
       checkIfUserisloggedin()
    }
    @objc func handleNewMessage(){
        let newMessageController=NewMessageController()
        let navController=UINavigationController(rootViewController: newMessageController)
        present(navController, animated: true, completion: nil)
    }
    
    func checkIfUserisloggedin(){
        //user is not logged in
        if Auth.auth().currentUser?.uid==nil{
            perform(#selector(handlelogout), with: nil, afterDelay: 0)
            handlelogout()
        } else{
            let  uid = Auth.auth().currentUser?.uid
            
            Database.database().reference().child("users").child(uid!).observe(.value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String:AnyObject]{
                    
                    self.navigationItem.title = dictionary["name"] as? String
                }
            }, withCancel: nil)
        }
        
    }
    @objc func handlelogout() {
        do{
            try  Auth.auth().signOut()
        }catch let logoutError{
            print(logoutError)
        }
       
        let logincontroller = loginController()
        
        present(logincontroller,animated:true, completion: nil)
        
        
    }
    


}

