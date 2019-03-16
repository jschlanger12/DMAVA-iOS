//
//  LoginViewController.swift
//  Practicum
//
//  Created by dev on 11/19/18.
//  Copyright © 2018 Monmouth University. All rights reserved.
//

import UIKit
import SideMenu

class LoginViewController: UIViewController {
    
    let userModel = UserModel.sharedInstance

    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: Any) {
        let un = Username.text
        let pw = Password.text
        
        userModel.verifyLogin(email: un!, password: pw!,
                              completionHandler: { (success) in
                                if (success) {
                                    print ("login successful")
                                    //                                    self.message.text = "success"
                                    //self.userModel.initCurrentUsers()
                                    //SideMenuManager.default.menuPushStyle = .preserve
                                    self.performSegue(withIdentifier: "successLogin", sender: self)
                                }
                                else {
                                    print ("login failed")
                                    //                                    self.message.text = "login failed"
                                }
        })
    }
    
    @IBAction func forgotPWUN(_ sender: Any) {
        performSegue(withIdentifier: "forgotPWUNSegue", sender: self)
    }
    
    @IBAction func createAccount(_ sender: Any) {
        performSegue(withIdentifier: "createAccountSegue", sender: self)
    }
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {}
    
    // MARK: - Navigation

    //In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//    }
 

}
