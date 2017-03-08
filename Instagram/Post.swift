//
//  Post.swift
//  Instagram
//
//  Created by William Huang on 3/7/17.
//  Copyright © 2017 William Huang. All rights reserved.
//

import UIKit
import Parse

class Post: NSObject {
    
    var media: PFFile
    var author: PFUser
    var caption: String?
    var likesCount: Int
    var commentsCount: Int
    
    init(pfObject: PFObject) {
        self.media = pfObject["media"] as! PFFile
        self.author = pfObject["author"] as! PFUser
        self.caption = pfObject["caption"] as? String
        self.likesCount = pfObject["likesCount"] as! Int
        self.commentsCount = pfObject["commentsCount"] as! Int
    }
    
    
    /**
     Method to add a user post to Parse (uploading image file)
     
     - parameter image: Image that the user wants upload to parse
     - parameter caption: Caption text input by the user
     - parameter completion: Block to be executed after save operation is complete
     */
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let post = PFObject(className: "Post")
        
        // Add relevant fields to the object
        post["media"] = getPFFileFromImage(image: image) // PFFile column type
        post["author"] = PFUser.current() // Pointer column type that points to PFUser
        post["caption"] = caption
        post["likesCount"] = 0
        post["commentsCount"] = 0
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackground(block: completion)
    }
    
    /**
     Method to convert UIImage to PFFile
     
     - parameter image: Image that the user wants to upload to parse
     
     - returns: PFFile for the the data in the image
     */
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
    /**
     Method to fetch the most recent 20 posts on the server
     
     - parameter posts: Closure to be executed with the received posts from the query
     - parameter error: Closure to be executed with an optional error
     */
    class func getPosts(success: @escaping ([Post]) -> (), failure: @escaping (Error?) -> ()) {
        // construct PFQuery
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackground { (pfObjects: [PFObject]?, error: Error?) in
            if let pfObjects = pfObjects {
                let posts = constructPostsArray(pfObjects: pfObjects)
                success(posts)
            } else {
                failure(error)
            }
        }
    }
    
    /**
     Method to convert an array of PFObjects to an array of Posts
     
     - parameter pfObjects: An array of pfObjects to be constructed into Posts
     
     - returns: An array of Posts
     */
    class func constructPostsArray(pfObjects: [PFObject]) -> [Post] {
        var posts: [Post] = []
        for pfObject in pfObjects {
            posts.append(Post(pfObject: pfObject))
        }
        return posts
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
