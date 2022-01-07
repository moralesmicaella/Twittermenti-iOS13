//
//  TweetManager.swift
//  Twittermenti
//
//  Created by Micaella Morales on 1/6/22.
//  Copyright © 2022 London App Brewery. All rights reserved.
//

import Foundation
import Swifter
import SwiftyJSON

struct TweetManager {
    
    private let tweetCount = 100
    
    private var config: [String: Any]? {
        guard let secretsPlistPath = Bundle.main.path(forResource: "Secrets", ofType: "plist") else {
            fatalError("App could not find the path for Secrets.plist")
        }
        return NSDictionary(contentsOfFile: secretsPlistPath) as? [String: Any]
    }
    
    private var swifter: Swifter?
    
    init() {
        if let apiKey = config?["API key"] as? String,
            let apiSecret = config?["API secret"] as? String {
            swifter = Swifter(consumerKey: apiKey, consumerSecret: apiSecret)
        }
    }
    
    func fetchTweets(with keyword: String, completion: @escaping ([TweetSentimentClassifierInput]?) -> Void){
        swifter?.searchTweet(using: keyword, lang: "en", count: tweetCount,  tweetMode: .extended, success: { results, searchMetadata in
            var tweets = [TweetSentimentClassifierInput]()
            for i in 0..<tweetCount {
                if let tweet = results[i]["full_text"].string {
                    let tweetForClassification = TweetSentimentClassifierInput(text: tweet)
                    tweets.append(tweetForClassification)
                }
            }
            completion(tweets)
        }, failure: { error in
            print("There was an error with the Twitter API Request, \(error)")
        })
    }
    
    
    
    
}
