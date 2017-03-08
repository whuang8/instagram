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

    @IBOutlet weak var postImageView: PFImageView!
    var post: Post! {
        didSet {
            self.postImageView.file = post.media
            self.postImageView.loadInBackground()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
