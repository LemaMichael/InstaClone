//
//  PreviewPhotoContainerView.swift
//  InstaClone
//
//  Created by Michael Lema on 10/14/18.
//  Copyright © 2018 Michael Lema. All rights reserved.
//

import Foundation
import UIKit
import Photos

class PreviewPhotoContainerView: UIView {
    
    let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "cancel_shadow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    let previewImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "save_shadow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleCancel() {
        self.removeFromSuperview()
    }
    
    fileprivate func displaySuccessAnimation() {
        DispatchQueue.main.async {
            let savedLabel = UILabel()
            savedLabel.text = "Saved Successfully"
            savedLabel.font = UIFont.boldSystemFont(ofSize: 18)
            savedLabel.textAlignment = .center
            savedLabel.textColor = .white
            savedLabel.numberOfLines = 0
            savedLabel.backgroundColor = UIColor(white: 0, alpha: 0.3)
            savedLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 80)
            savedLabel.center = self.center
            self.addSubview(savedLabel)
            
            savedLabel.layer.transform = CATransform3DMakeScale(0, 0, 0)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                
                savedLabel.layer.transform = CATransform3DMakeScale(1, 1, 1)
                
            }, completion: { (completed) in
                
                UIView.animate(withDuration: 0.5, delay: 0.75, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    
                    savedLabel.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1)
                    savedLabel.alpha = 0
                }, completion: { (_) in
                    savedLabel.removeFromSuperview()
                })
                
            })
        }
    }
    
    @objc fileprivate func handleSave() {
        
        guard let previewImage = previewImageView.image else { return }
        
        let library = PHPhotoLibrary.shared()
        library.performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: previewImage)
        }) { (success, error) in
            if let error = error {
                print("Failed to save image to photo library: ", error)
                return
            }
            print("Successfully saved image to library.")
            self.displaySuccessAnimation()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(previewImageView)
        addSubview(cancelButton)
        addSubview(saveButton)
        previewImageView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        
        cancelButton.anchor(top: topAnchor, bottom: nil, left: leftAnchor, right: nil, paddingTop: 12, paddingBottom: 0, paddingLeft: 12, paddingRight: 0, width: 50, height: 50)
        
        saveButton.anchor(top: nil, bottom: bottomAnchor, left: leftAnchor, right: nil, paddingTop: 0, paddingBottom: 24, paddingLeft: 24, paddingRight: 0, width: 50, height: 50)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
