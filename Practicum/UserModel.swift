//
//  UserModel.swift
//  Practicum
//
//  Created by dev on 1/27/19.
//  Copyright © 2019 Monmouth University. All rights reserved.
//

import Foundation
import FirebaseAuth

class UserModel{
    
    static let sharedInstance = UserModel ()
    
    private init() {
        
    }
    
    func verifyLogin (email userEmail: String, password pw: String, completionHandler: @escaping (_ sucess: Bool)  -> () ) {
        Auth.auth().signIn(withEmail: userEmail, password: pw, completion: { (loggedInUser, error) in
            if error == nil {
                print ("login successful")
                //                self.saveUserCredentials(withEmail: userEmail, andPassword: pw)
                //
                //                if let uid = loggedInUser?.user.uid {
                //
                //                    self.getCurrentUser(uid: uid)
                //                }
                //
                //                self.currentUserEmail = userEmail
                //
                completionHandler(true)
            }
            else {
                print ("login failed")
                print ((error?.localizedDescription)!)
                completionHandler (false)
            }
        })
        
    }
    
    func registerUser (email userEmail: String, password pw: String, userName name: String, completionHandler: @escaping (_ success: Bool) -> ())
    {
        //let userRef = Database.database().reference(withPath: "users")
        
        Auth.auth().createUser(withEmail: userEmail,
                               password: pw) { newUser, error in
                                if error == nil {
                                    //                                    let newUser = RegisteredUser(uid: (newUser?.user.uid)!, email: userEmail, name: name)
                                    //                                    userRef.child(newUser.uid).setValue(newUser.toAnyObject())
                                    //                                    self.saveUserCredentials(withEmail: userEmail, andPassword: pw)
                                    completionHandler(true)
                                }
                                else {
                                    completionHandler(false)
                                }
        }
        
        
    }
    
}

