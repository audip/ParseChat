//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Aditya Purandare on 17/02/16.
//  Copyright © 2016 Aditya Purandare. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var messagesList: [PFObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "onTimer", userInfo: nil, repeats: true)
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    func onTimer() {
        
        let query = PFQuery(className: "Message")
        query.whereKey("text", notEqualTo: "")
        query.includeKey("User")
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock {
            (messages: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                print("Successfully retrieved messages: \(messages!.count)")
                if let messages = messages {
                    self.messagesList = messages
                    for message in messages {
                        print("Message: \(message["text"]) + User: \(message["User"])")
                    }
                }
                self.tableView.reloadData()
            } else {
                let errorString = error!.userInfo["error"] as? NSString
                print("Error message: \(errorString)")
            }
        }
        self.tableView.reloadData()
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
            message["User"] = PFUser.currentUser()?.username
            message.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    print("Message: \(msgText!) has been sent")
                    self.messageTextField.text = ""
                } else {
                    let errorString = error!.userInfo["error"] as? NSString
                    print("Error message: \(errorString)")
                }
            }
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let messages = messagesList{
            return messages.count
        } else {
            return 0
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MessageCell", forIndexPath: indexPath) as! MessageCell
        
        cell.messageLabel.text = messagesList![indexPath.row]["text"] as? String
        cell.usernameLabel.text = messagesList![indexPath.row]["User"] as? String
        
        return cell
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
