//
//  CommentsCell.swift
//  InstaClone
//
//  Created by Michael Lema on 10/14/18.
//  Copyright © 2018 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class CommentsCell: UICollectionViewCell {
    
    var comment: Comment? {
        didSet {
            
            guard let comment = comment else { return }
            let profileImageURL = comment.user.profileImageUrl
            let username = comment.user.username 
            
            let attributedText = NSMutableAttributedString(string: username, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
            
            attributedText.append(NSAttributedString(string: " " + comment.text, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
            
            
            textView.attributedText = attributedText
            profileImageView.loadImage(urlString: profileImageURL)
        }
    }
    
    let profileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isScrollEnabled = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileImageView)
        addSubview(textView)
        
        profileImageView.anchor(top: topAnchor, bottom: nil, left: leftAnchor, right: nil, paddingTop: 8, paddingBottom: 0, paddingLeft: 8, paddingRight: 0, width: 40, height: 40)
        profileImageView.layer.cornerRadius = 40 / 2
        
        
        textView.anchor(top: topAnchor, bottom: bottomAnchor, left: profileImageView.rightAnchor, right: rightAnchor, paddingTop: 4, paddingBottom: 4, paddingLeft: 4, paddingRight: 4, width: 0, height: 0)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
