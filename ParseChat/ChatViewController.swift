//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Aditya Purandare on 17/02/16.
//  Copyright © 2016 Aditya Purandare. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {

    @IBOutlet weak var messageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSend(sender: AnyObject) {
        let message = PFObject(className: "Message")
        let msgText = messageTextField.text
        if msgText != nil {
            message["text"] = msgText!
            message.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    print("Message: \(msgText) has been sent")
                    self.messageTextField.text = ""
                } else {
                    let errorString = error!.userInfo["error"] as? NSString
                    print("Error message: \(errorString)")
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
