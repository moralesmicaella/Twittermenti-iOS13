//
//  ViewController.swift
//  Twittermenti
//
//  Created by Angela Yu on 17/07/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit
import Swifter

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    let tweetManager = TweetManager()
    var sentimentManager = SentimentManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func predictPressed(_ sender: Any) {
        if let searchText = textField.text {
            tweetManager.fetchTweets(with: searchText) { tweets in
                if let tweets = tweets {
                    let sentimentScore = self.sentimentManager.getSentiment(of: tweets)
                    print(sentimentScore)
                    self.setSentimentLabel(using: sentimentScore)
                }
            }
        }
    }
    
    func setSentimentLabel(using sentimentScore: Int) {
        if sentimentScore > 20 {
            sentimentLabel.text = "😍"
        } else if sentimentScore > 10 {
            sentimentLabel.text = "😃"
        } else if sentimentScore > 0 {
            sentimentLabel.text = "🙂"
        } else if sentimentScore == 0 {
            sentimentLabel.text = "😐"
        } else if sentimentScore > -10 {
            sentimentLabel.text = "😕"
        } else if sentimentScore > -20  {
            sentimentLabel.text = "😡"
        } else {
            sentimentLabel.text = "🤮"
        }
    }
    
}

