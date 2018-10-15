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
            textLabel.text = comment?.text
        }
    }
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.backgroundColor = .lightGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(textLabel)
        backgroundColor = .yellow
        
        textLabel.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 4, paddingBottom: 4, paddingLeft: 4, paddingRight: 4, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
