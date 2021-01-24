//
//  Constants.swift
//  GMSampleApp
//
//  Created by K Madeve Gowda on 24/01/21.
//  Copyright © 2021 sheela. All rights reserved.
//

import Foundation

struct Constants {
    
    struct Service {
        
        static let baseUrl:String = "https://api.github.com"
        static let repoName:String = "KarthikGowda022/GMSampleApp"
        static let numberOfCommits = "25"
    }
    
    struct Views {
        static let navigationTitle:String = "Git log"
        static let cellIdentifier:String = "CommitCell"
    }
}
