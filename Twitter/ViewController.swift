//
//  ViewController.swift
//  Twitter
//
//  Created by Rian Walker on 2/14/16.
//  Copyright © 2016 Rian Walker. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: AnyObject) {
        
        TwitterClient.sharedInstance.loginWithCompletion(){
            (user: User?, error: NSError?) in
            if user != nil {
                print("I've logged in.")
                self.performSegueWithIdentifier("loginSegue", sender: <#T##AnyObject?#>)
            } else {
                // handle login error
                print(error)
            }
        }
    }
}

