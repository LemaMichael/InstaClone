//
//  UserProfileHeader.swift
//  InstaClone
//
//  Created by Michael Lema on 10/6/18.
//  Copyright © 2018 Michael Lema. All rights reserved.
//

import UIKit

class UserProfileHeader: UICollectionViewCell {
    
    var user: User? {
        didSet {
            setupProfileImage()
            usernameLabel.text = user?.username
        }
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let postsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        
        let attributedText = NSMutableAttributedString(string: "11\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "posts", attributes: [.foregroundColor: UIColor.lightGray, .font: UIFont.systemFont(ofSize: 14)]))
        label.attributedText = attributedText
        
        label.textAlignment = .center
        return label
    }()
    let followersLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        
        let attributedText = NSMutableAttributedString(string: "0\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "followers", attributes: [.foregroundColor: UIColor.lightGray, .font: UIFont.systemFont(ofSize: 14)]))
        label.attributedText = attributedText
        
        label.textAlignment = .center
        return label
    }()
    let followingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        
        let attributedText = NSMutableAttributedString(string: "0\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "following", attributes: [.foregroundColor: UIColor.lightGray, .font: UIFont.systemFont(ofSize: 14)]))
        label.attributedText = attributedText
        
        label.textAlignment = .center
        return label
    }()
    
    let editProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 3
        return button
    }()
    
    let gridButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
        return button
    }()
    let listButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "list"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileImageView)
        addSubview(usernameLabel)
        addSubview(editProfileButton)
        
        profileImageView.anchor(top: topAnchor, bottom: nil, left: leftAnchor, right: nil, paddingTop: 12, paddingBottom: 0, paddingLeft: 12, paddingRight: 0, width: 80, height: 80)
        profileImageView.layer.cornerRadius = 80 / 2
        profileImageView.clipsToBounds = true
        
        setupBottomToolbar()
        
        usernameLabel.anchor(top: profileImageView.bottomAnchor, bottom: gridButton.topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 4, paddingBottom: 0, paddingLeft: 12, paddingRight: 12, width: 0, height: 0)
        
        setupUserStats()
        
        editProfileButton.anchor(top: postsLabel.bottomAnchor, bottom: nil, left: postsLabel.leftAnchor, right: followingLabel.rightAnchor, paddingTop: 2, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 34)
    }
    
    fileprivate func setupBottomToolbar() {
        
        let topDividerView = UIView()
        topDividerView.backgroundColor = .lightGray
        let bottomDividerView = UIView()
        bottomDividerView.backgroundColor = .lightGray
        
        let stackView = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
        stackView.distribution = .fillEqually
        addSubview(stackView)
        addSubview(topDividerView)
        addSubview(bottomDividerView)
        stackView.anchor(top: nil, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 50)
        topDividerView.anchor(top: stackView.topAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0.5)
        bottomDividerView.anchor(top: stackView.bottomAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0.5)
    }
    
    fileprivate func setupUserStats() {
        let stackView = UIStackView(arrangedSubviews: [postsLabel, followersLabel, followingLabel])
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.anchor(top: topAnchor, bottom: nil, left: profileImageView.rightAnchor, right: rightAnchor, paddingTop: 12, paddingBottom: 0, paddingLeft: 12, paddingRight: 12, width: 0, height: 50)
    }
    
    fileprivate func setupProfileImage() {
        guard let profileImageUrl = user?.profileImageUrl else { return }
        guard let url = URL(string: profileImageUrl) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to fetch Profile image: ", error)
            }
            guard let data = data else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self.profileImageView.image = image
            }
            }.resume()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
