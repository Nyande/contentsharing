 //
//  loginController.swift
//  chat
//
//  Created by K2 Paul on 31/03/2019.
//  Copyright © 2019 K2 Paul. All rights reserved.
//

import UIKit
 import Firebase

class loginController: UIViewController {
    
    
    //Main container
    let inputsContainerView:UIView={
        let view = UIView()
        
        view.backgroundColor=UIColor.white
        view.translatesAutoresizingMaskIntoConstraints=false
        view.layer.cornerRadius=5
        view.layer.masksToBounds=true
        return view
        
    }()
   //registration button
    lazy var loginregisterbutton:UIButton={
        let Button=UIButton(type:.system)
       Button.backgroundColor=UIColor(r: 80, g: 101, b: 161)
        Button.setTitle("Sign Up", for: .normal)
        Button.setTitleColor(UIColor.white, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints=false
        Button.titleLabel?.font=UIFont.boldSystemFont(ofSize: 16)
        Button.layer.cornerRadius=10
        Button.layer.masksToBounds=true
        
        Button.addTarget(self, action: #selector(handleLoginregister), for:.touchUpInside)
        return Button
    }()
    @objc func handleLoginregister(){
        if loginRegisterSegmentedControl.selectedSegmentIndex==0{
            handlelogin()
        }else{
            handleRegister()
        }
    }
    func handlelogin(){
        guard let email=emailTextField.text,let password=passwordTextField.text
             else{
                print("Form is not valid")
                return
        }
        Auth.auth().signIn(withEmail: email, password: password) { (user,error) in
            
            if error  != nil{
                print (error as Any)
                return
            }
            //successfully logged in our user
            self.dismiss(animated: true, completion: nil)
        }
    }
    @objc func handleRegister(){
        guard let email=emailTextField.text,let password=passwordTextField.text, let name=nameTextField.text
            else{
            print("Form is not valid")
            return
        }
      Auth.auth().createUser(withEmail: email, password: password) {authResult,error
        

          
            in
    if error != nil{
        print(error as Any)
                return
    }
        
        
            //Successful authentication of user
    let ref = Database.database().reference(fromURL: "https://chat-df16b.firebaseio.com/")
    
        let usersReference=ref.child("users")
            
  
    let values=["name":name,"email":email]
    usersReference.updateChildValues(values){(err,ref)
        in
        if err != nil{
            print(err as Any)
            return
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
        }
    }
    //name text feild
    let nameTextField:UITextField={
        let tf=UITextField()
        tf.placeholder="Full Name"
        tf.translatesAutoresizingMaskIntoConstraints=false
        return tf
    }()
    //name line separator
    let nameseperatorView:UIView={
        let view=UIView()
        view.backgroundColor=UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints=false
        return view
    }()
    //Email text field
    let emailTextField:UITextField={
        let tf=UITextField()
        tf.placeholder="Email"
        tf.translatesAutoresizingMaskIntoConstraints=false
        return tf
    }()
    //email line separator
    let emailseperatorView:UIView={
        let view=UIView()
        view.backgroundColor=UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints=false
        return view
    }()
    //password textfield
    
    let passwordTextField:UITextField={
        let tf=UITextField()
        tf.placeholder="Password"
        tf.translatesAutoresizingMaskIntoConstraints=false
        tf.isSecureTextEntry=true
        return tf
    }()
    //setprofile pic
    let profileImageView:UIImageView={
        let imageview = UIImageView()
        imageview.image=UIImage(named: "Get")
        imageview.translatesAutoresizingMaskIntoConstraints=false
        imageview.contentMode = .scaleAspectFill
        return imageview
        
    }()
   lazy var loginRegisterSegmentedControl: UISegmentedControl={
        let sc=UISegmentedControl(items:["Login","Register"])
        sc.translatesAutoresizingMaskIntoConstraints=false
        sc.tintColor=UIColor.white;
        sc.selectedSegmentIndex=1
        sc.addTarget(self, action:#selector(handleloginregistrationchanged), for: .valueChanged)
        return sc
        
    }()
    
    @objc func handleloginregistrationchanged(){
        let title=loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        loginregisterbutton.setTitle(title, for: .normal)
   
          //change height of input container
        inputscontainerviewheightanchor?.constant=loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 100 : 150
        //change height of input container view
        nameTextFieldHeightanchor?.isActive=false
        nameTextFieldHeightanchor=nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1/3)
        nameTextFieldHeightanchor?.isActive=true
        
        emailtextfieldheightanchor?.isActive=false
        emailtextfieldheightanchor=emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        emailtextfieldheightanchor?.isActive=true
        
        passwordtextfieldheightanchor?.isActive=false
        passwordtextfieldheightanchor=passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        passwordtextfieldheightanchor?.isActive=true
        
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor=UIColor(r: 61, g: 91, b: 155)
       
        //adding the different views to the main view controller and calling the method
        view.addSubview(inputsContainerView)
        view.addSubview(loginregisterbutton)
        view.addSubview(profileImageView)
        view.addSubview(loginRegisterSegmentedControl)
        
        
    setupinputscontainerview()
    setuploginregistrationbutton()
    setupprofileimageview()
    setupLoginRegistersSegmentedControl()
    
    }
    
    func setupLoginRegistersSegmentedControl(){
        //x,y,widith ,height constraints
        loginRegisterSegmentedControl.centerXAnchor .constraint(equalTo: view.centerXAnchor).isActive=true
        loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive=true
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive=true
        loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 50).isActive=true
        
        
    }
    func setupprofileimageview(){
        //x,y,widith ,height constraints for the picture holder
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        profileImageView.bottomAnchor.constraint(equalTo: loginRegisterSegmentedControl.topAnchor, constant: -12).isActive=true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive=true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive=true
        
    }
    var inputscontainerviewheightanchor:NSLayoutConstraint?
    var nameTextFieldHeightanchor: NSLayoutConstraint?
    var emailtextfieldheightanchor:NSLayoutConstraint?
     var passwordtextfieldheightanchor:NSLayoutConstraint?
    func setupinputscontainerview(){
        
        //x,y,widith ,height constraints for container holding the views
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive=true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor,constant: -24).isActive=true
      inputscontainerviewheightanchor = inputsContainerView.heightAnchor.constraint(equalToConstant: 150)
        inputscontainerviewheightanchor?.isActive=true
        
        
        //adding sub views to the main container
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(nameseperatorView)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailseperatorView)
        inputsContainerView.addSubview(passwordTextField)
        
        //x,y,widith ,height constraints for the name text field
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive=true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive=true
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: 12).isActive=true
        nameTextFieldHeightanchor=nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
      nameTextFieldHeightanchor?.isActive=true
        
        
        
        //x,y,widith ,height constraints of line separator
        nameseperatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive=true
        nameseperatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive=true
        nameseperatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive=true
        nameseperatorView.heightAnchor.constraint(equalToConstant: 1).isActive=true
        
        //x,y,widith ,height constraints for the email text field
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive=true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive=true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: 12).isActive=true
        
        emailtextfieldheightanchor=emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        emailtextfieldheightanchor?.isActive=true
        
        
        //x,y,widith ,height constraints of line separatorn after email
        emailseperatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive=true
        emailseperatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive=true
        emailseperatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive=true
        emailseperatorView.heightAnchor.constraint(equalToConstant: 1).isActive=true
        
        //x,y,widith ,height constraints for the password text field
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive=true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive=true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: 12).isActive=true
        
        passwordtextfieldheightanchor=passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        
        passwordtextfieldheightanchor?.isActive=true
        
    }
    func setuploginregistrationbutton(){
         //x,y,widith ,height constraints for the registration button
        loginregisterbutton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        loginregisterbutton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive=true
        loginregisterbutton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive=true
        loginregisterbutton.heightAnchor.constraint(equalToConstant: 30).isActive=true
    }
    
    
    //setting the style bar to be white colour.. the light content means that the status bar will have a light
    //colour which will be white.
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return.lightContent
    }

 
    }
 extension UIColor{
    
    //setting the colour inorder to just call the method
    convenience init(r:CGFloat,g:CGFloat,b:CGFloat){
    self.init(red: r/255,green:g/255,blue:b/255,alpha:1)
    }
 }


