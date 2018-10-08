//
//  Post.swift
//  InstaClone
//
//  Created by Michael Lema on 10/8/18.
//  Copyright © 2018 Michael Lema. All rights reserved.
//

import UIKit

struct Post {
    
    let user: User
    let imageURL: String
    let caption: String
    
    init(user: User, dictionary: [String: Any]) {
        self.user = user
        self.imageURL = dictionary["imageUrl"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
    }
}
