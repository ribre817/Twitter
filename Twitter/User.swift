//
//  User.swift
//  Twitter
//
//  Created by Rian Walker on 2/15/16.
//  Copyright © 2016 Rian Walker. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileImageURL: NSURL?
    var tagline: String?
    
    init(dictionary: NSDictionary){
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        
        
        let profileURLString = dictionary["profile_image_url_https"] as? String
        if let profileURLString = profileURLString{
            profileImageURL = NSURL(string: profileURLString)
        }
        
        tagline = dictionary["tagline"] as? String
    }
}
