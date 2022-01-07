//
//  TweetSentimentClassifierManager.swift
//  Twittermenti
//
//  Created by Micaella Morales on 1/6/22.
//  Copyright © 2022 London App Brewery. All rights reserved.
//

import Foundation
import CoreML
import NaturalLanguage

struct SentimentManager {
    
    private var sentimentClassifier: TweetSentimentClassifier?
    
    init() {
        do {
            sentimentClassifier = try TweetSentimentClassifier(configuration: MLModelConfiguration())
        } catch {
            print("There was an error with creating a Tweet Sentiment Classifier instance, \(error)")
        }
    }
    
    mutating func getSentiment(of tweets: [TweetSentimentClassifierInput]) -> Int {
        var sentimentScore = 0
        
        do {
            if let predictions = try sentimentClassifier?.predictions(inputs: tweets) {
                for prediction in predictions {
                    let sentiment = prediction.label
                    if sentiment == "Pos" {
                        sentimentScore += 1
                    } else if sentiment == "Neg" {
                        sentimentScore -= 1
                    }
                }
            }
        } catch {
            print("There was an error with making a prediction, \(error)")
        }
        
        return sentimentScore
    }
    
    
}
