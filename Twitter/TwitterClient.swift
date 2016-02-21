//
//  TwitterClient.swift
//  Twitter
//
//  Created by Rian Walker on 2/14/16.
//  Copyright © 2016 Rian Walker. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "yS8a0VGyzNSwOdiz2bViCVqFf"
let twitterConsumerSecret = "WoafyEB5xbRfjsmdbbSkUVFE5dKnLiqZx2m54cIy0bvECdafyw"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(
                baseURL: twitterBaseURL,
                consumerKey: twitterConsumerKey,
                consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }

}
