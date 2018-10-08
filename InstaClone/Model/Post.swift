//
//  Post.swift
//  InstaClone
//
//  Created by Michael Lema on 10/8/18.
//  Copyright © 2018 Michael Lema. All rights reserved.
//

import UIKit

struct Post {
    let imageURL: String
    
    
    init(dictionary: [String: Any]) {
        self.imageURL = dictionary["imageUrl"] as? String ?? ""
        
    }
}
