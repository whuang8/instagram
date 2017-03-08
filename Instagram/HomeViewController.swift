//
//  HomeViewController.swift
//  Instagram
//
//  Created by William Huang on 3/7/17.
//  Copyright © 2017 William Huang. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        PFUser.logOutInBackground { (error: Error?) in
            if error == nil {
                NotificationCenter.default.post(name: PFUser.userDidLogoutNotification, object: nil)
            } else {
                // Display error
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
