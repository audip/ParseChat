//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Aditya Purandare on 17/02/16.
//  Copyright © 2016 Aditya Purandare. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onSignup(sender: AnyObject) {
        let user = PFUser()
        user.email = emailTextField.text
        user.password = passwordTextField.text
        
        let alertController = UIAlertController(title: "Username required", message: "No username has been entered", preferredStyle: .Alert)
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo["error"] as? NSString
                print("Error message: \(errorString)")
                
                // create a cancel action
                let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
                    // handle cancel response here. Doing nothing will dismiss the view.
                }
                // add the cancel action to the alertController
                alertController.addAction(cancelAction)
                
                // create an OK action
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                    // handle response here.
                }
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                
                self.presentViewController(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
            } else {
                //Let them use the app now.
            }
        }
    }
    
    @IBAction func onLogin(sender: AnyObject) {
        
        let email = emailTextField?.text
        let password = passwordTextField?.text
        
        let alertController = UIAlertController(title: "Username/password required", message: "No username/password has been entered", preferredStyle: .Alert)
        
        if email != nil && password != nil {
            PFUser.logInWithUsernameInBackground(email!, password: password!){
                (user: PFUser?, error: NSError?) -> Void in
                if user != nil {
                    // Log them in
                } else {
                    let errorString = error!.userInfo["error"] as? NSString
                    print("Error message: \(errorString)")
                    
                    // create a cancel action
                    let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
                        // handle cancel response here. Doing nothing will dismiss the view.
                    }
                    // add the cancel action to the alertController
                    alertController.addAction(cancelAction)
                    
                    // create an OK action
                    let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                        // handle response here.
                    }
                    // add the OK action to the alert controller
                    alertController.addAction(OKAction)
                    
                    self.presentViewController(alertController, animated: true) {
                        // optional code for what happens after the alert controller has finished presenting
                    }
                }
            }
        }
    }

}
