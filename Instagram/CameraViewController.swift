//
//  CameraViewController.swift
//  Instagram
//
//  Created by William Huang on 3/7/17.
//  Copyright © 2017 William Huang. All rights reserved.
//

import UIKit
import MBProgressHUD

class CameraViewController: UIViewController {

    @IBOutlet weak var captionView: UITextView!
    @IBOutlet weak var postImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if postImageView.image == nil {
            instantiateImagePickerController()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        postImageView.image = nil
        tabBarController?.selectedIndex = 0
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        Post.postUserImage(image: postImageView.image, withCaption: captionView.text) { (success: Bool, error: Error?) in
            if success {
                MBProgressHUD.hide(for: self.view, animated: true)
                self.postImageView.image = nil
                self.tabBarController?.selectedIndex = 0
            } else {
                MBProgressHUD.hide(for: self.view, animated: true)
                print("error: \(error)")
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

// UIImagePickerController methods
extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func instantiateImagePickerController() {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.camera
        
        self.present(vc, animated: true, completion: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        //let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        postImageView.image = editedImage
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.tabBarController?.selectedIndex = 0
        dismiss(animated: true, completion: nil)
    }
}
