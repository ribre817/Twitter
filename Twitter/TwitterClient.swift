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

var loginCompletion: ((user: User?, error: NSError?) -> ())?

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
    
    func handleOpenURL(url: NSURL){
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: {(accessToken: BDBOAuth1Credential!) -> Void in
            
            self.currentAccount()
            
            
            }){ (error: NSError!) -> Void in
                print("Error getting access token.")}
    }
    
    func loginWithCompletion(success: ([Tweet]) -> (), failure: (NSError) -> ()){
        // Fetch request token.
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterRian://oauth"), scope: nil,
            success: { (requestToken: BDBOAuth1Credential!) -> Void in
                let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
                UIApplication.sharedApplication().openURL(authURL!)
        
            }, failure: { (error: NSError!) -> Void in
                print("Failed to get request token: \(error)")
                })
    }
    
        
    
    func homeTimeLine(success: ([Tweet]) -> (), failure: (NSError) -> ()){
        GET("1.1/statuses/home_timeline.json", parameters: nil, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            //print("Home_Timeline: \(response)")
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries)
            
            success(tweets)
            
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
        
    }
   func currentAccount(){
        GET("1.1/account/verify_credentials.json", parameters: nil, success: {(operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
        let userDictionary = response as! NSDictionary
        
        let user = User(dictionary: userDictionary)
        print("User: \(user)")
        print("Name: \(user.name)")
        print("Screenname: \(user.screenname)")
        print("ProfileURL: \(user.profileImageURL)")
        print("Description: \(user.tagline)")
        
        }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
            
        })
    }
}