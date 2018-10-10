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
    let creationDate: Date
    
    init(user: User, dictionary: [String: Any]) {
        self.user = user
        self.imageURL = dictionary["imageUrl"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
        
        let secondsFrom1970 = dictionary["creationDate"] as? Double ?? 0
        self.creationDate = Date(timeIntervalSince1970: secondsFrom1970)
    
    }
}
