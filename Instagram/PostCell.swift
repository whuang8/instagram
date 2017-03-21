//
//  PostCell.swift
//  Instagram
//
//  Created by William Huang on 3/7/17.
//  Copyright © 2017 William Huang. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var commentUsernameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var postImageView: PFImageView!
    var post: Post! {
        didSet {
            self.postImageView.file = post.media
            self.postImageView.loadInBackground()
            self.usernameLabel.text = post.author.username
            self.commentUsernameLabel.text = post.author.username
            self.captionLabel.text = post.caption
            self.profileImageView.image = UIImage(named: "insta-colors")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.profileImageView.layer.cornerRadius = self.profileImageView.bounds.width/2
        self.profileImageView.clipsToBounds = true
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
