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

    @IBOutlet weak var tableView: UITableView!
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        getPosts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getPosts() {
        Post.getPosts(success: { (posts: [Post]) in
            self.posts = posts
            self.tableView.reloadData()
        }) { (error: Error?) in
            print("error: \(error?.localizedDescription)")
        }
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

// UITableView methods
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        let post = posts[indexPath.row]
        cell.post = post
        return cell
    }
}
