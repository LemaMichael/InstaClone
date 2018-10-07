//
//  SharePhotoController.swift
//  InstaClone
//
//  Created by Michael Lema on 10/7/18.
//  Copyright © 2018 Michael Lema. All rights reserved.
//

import UIKit
import Firebase

class SharePhotoController: UIViewController {
    
    var selectedImage: UIImage? {
        didSet {
            self.imageView.image = selectedImage
        }
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 250)
        
        let shareButton = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handleShare))
        navigationItem.rightBarButtonItem = shareButton
        
        setupImageAndTextViews()
    }
    
    fileprivate func setupImageAndTextViews() {
        let containerView = UIView()
        containerView.backgroundColor = .white
        view.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(textView)
        
        containerView.anchor(top: topLayoutGuide.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 100)
        
        imageView.anchor(top: containerView.topAnchor, bottom: containerView.bottomAnchor, left: containerView.leftAnchor, right: nil, paddingTop: 8, paddingBottom: 8, paddingLeft: 8, paddingRight: 0, width: 84, height: 0)
        textView.anchor(top: containerView.topAnchor, bottom: containerView.bottomAnchor, left: imageView.rightAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 4, paddingRight: 0, width: 0, height: 0)
        
    }
    
    @objc func handleShare() {
        guard let caption = textView.text, !caption.isEmpty else { return }
        guard let image = selectedImage else { return }
        guard let uploadData = image.jpegData(compressionQuality: 0.5) else { return }
        navigationItem.rightBarButtonItem?.isEnabled = false

        let fileName = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("posts").child(fileName)
        storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
            
            if let error = error {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                print("Failed to upload post image: ", error)
                return
            }
            
            print("Successfully uploaded post image")
            storageRef.downloadURL(completion: { (downloadURL, error) in
                if let error = error {
                    self.navigationItem.rightBarButtonItem?.isEnabled = true
                    print("Failed to fetch downloadURL: ", error)
                    return
                }
                guard let imageURL = downloadURL?.absoluteString else { return }
                print("Succesfully uploaded post image: ", imageURL)
                self.saveToDatabseWithImageUrl(imageURL: imageURL)
            })
            
        }
    }
    
    fileprivate func saveToDatabseWithImageUrl(imageURL: String) {
        guard let postImage = selectedImage else { return }
        guard let caption = textView.text else { return }
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userPostRef =  Database.database().reference().child("posts").child(uid)
        let ref = userPostRef.childByAutoId()
        
        let values = ["imageUrl": imageURL, "caption": caption, "imageWidth": postImage.size.width, "imageHeight": postImage.size.height, "creationDate": Date().timeIntervalSince1970] as [String : Any]
        
        ref.updateChildValues(values) { (error, databaseReference) in
            if let error = error {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                print("Failed to save post to database: ", error)
                return
            }
            print("Successfully saved post to database")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
