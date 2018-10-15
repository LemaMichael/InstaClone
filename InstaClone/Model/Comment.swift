//
//  Comment.swift
//  InstaClone
//
//  Created by Michael Lema on 10/14/18.
//  Copyright © 2018 Michael Lema. All rights reserved.
//

import UIKit

struct Comment {
    let text: String
    let uid: String
    
    init(dictionary: [String: Any]) {
        self.text = dictionary["text"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
