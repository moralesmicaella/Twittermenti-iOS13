//
//  TweetManager.swift
//  Twittermenti
//
//  Created by Micaella Morales on 1/6/22.
//  Copyright © 2022 London App Brewery. All rights reserved.
//

import Foundation
import Swifter

struct TweetManager {
    
    var config: [String: Any]? {
        guard let secretsPlistPath = Bundle.main.path(forResource: "Secrets", ofType: "plist") else {
            fatalError("App could not find the path for Secrets.plist")
        }
        return NSDictionary(contentsOfFile: secretsPlistPath) as? [String: Any]
    }
    
    var swifter: Swifter?
    
    init() {
        if let apiKey = config?["API key"] as? String,
            let apiSecret = config?["API secret"] as? String {
            swifter = Swifter(consumerKey: apiKey, consumerSecret: apiSecret)
        }
    }
    
    func getTextOfTweets(with keyword: String) {
        swifter?.searchTweet(using: keyword, lang: "en", count: 100,  tweetMode: .extended, success: { results, searchMetadata in
            print(results)
        }, failure: { error in
            print("There was an error with the Twitter API Request, \(error)")
        })
    }
    
    
    
    
}
