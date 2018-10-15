//
//  CommentsController.swift
//  InstaClone
//
//  Created by Michael Lema on 10/14/18.
//  Copyright © 2018 Michael Lema. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class CommentsController: UICollectionViewController {
    
    var post: Post?
    
    lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        containerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        
        let submitButton = UIButton(type: .system)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        containerView.addSubview(submitButton)
        submitButton.anchor(top: containerView.topAnchor, bottom: containerView.bottomAnchor, left: nil, right: containerView.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 12, width: 50, height: 0)
        
        containerView.addSubview(commentsTextField)
        commentsTextField.anchor(top: containerView.topAnchor, bottom: containerView.bottomAnchor, left: containerView.leftAnchor, right: submitButton.leftAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 12, paddingRight: 0, width: 0, height: 0)
        return containerView
    }()
    
    let commentsTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Comment"
        return textField
    }()
    
    @objc fileprivate func handleSubmit() {
        print("post id: ", self.post?.id ?? "")
        print("Inserting comment:", commentsTextField.text ?? "")
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let postId = self.post?.id ?? ""
        
        let values = ["text": commentsTextField.text ?? "", "creationDate": Date().timeIntervalSince1970, "uid": uid] as [String : Any]
        Database.database().reference().child("comments").child(postId).childByAutoId().updateChildValues(values) { (error, reference) in
            if let error = error {
                print("Failed to insert comment: ", error)
                return
            }
            print("Successfully inserted comment. ")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Comments"
        collectionView.backgroundColor = .white

    }
    
    override var inputAccessoryView: UIView? {
        get {
            return containerView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
}

// MARK:
extension CommentsController {
    
}


