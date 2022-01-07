//
//  ViewController.swift
//  Twittermenti
//
//  Created by Angela Yu on 17/07/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit
import Swifter
import Lottie

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet var animationView: AnimationView!
        
    let tweetManager = TweetManager()
    var sentimentManager = SentimentManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        setAnimationConfig()
    }

    @IBAction func predictPressed(_ sender: Any) {
        if let searchText = textField.text {
            tweetManager.fetchTweets(with: searchText) { tweets in
                if let tweets = tweets {
                    let sentimentScore = self.sentimentManager.getSentiment(of: tweets)
                    self.setSentimentLabel(using: sentimentScore)
                }
            }
        }
        textField.resignFirstResponder()
    }
    
    func setAnimationConfig() {
        animationView.animation = Animation.named("Animations/calm")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        
        animationView.play()
    }
    
    
    func setSentimentLabel(using sentimentScore: Int) {
        if sentimentScore > 20 {
            animationView.animation = Animation.named("Animations/heart-eyes")
        } else if sentimentScore > 10 {
            animationView.animation = Animation.named("Animations/laughing")
        } else if sentimentScore > 0 {
            animationView.animation = Animation.named("Animations/happy")
        } else if sentimentScore == 0 {
            animationView.animation = Animation.named("Animations/calm")
        } else if sentimentScore > -10 {
            animationView.animation = Animation.named("Animations/grieved")
        } else if sentimentScore > -20  {
            animationView.animation = Animation.named("Animations/angry")
        } else {
            animationView.animation = Animation.named("Animations/vomiting")
        }
        animationView.play()
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
}

