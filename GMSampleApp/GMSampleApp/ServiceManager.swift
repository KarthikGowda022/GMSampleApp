//
//  ServiceManager.swift
//  GMSampleApp
//
//  Created by K Madeve Gowda on 23/01/21.
//  Copyright © 2021 sheela. All rights reserved.
//

import Foundation

class ServiceManager {
    
    static let sharedManager = ServiceManager()
    
    func fetchGitCommits(_ completion:@escaping (([GitNode]?) -> Void)){
        
        guard let requestUrl = URL(string: "https://api.github.com/repos/KarthikGowda022/GMSampleApp/commits?per_page=25") else { return completion(nil)}
        
        
        let dataTask = URLSession.shared.dataTask(with: requestUrl) { (data, urlResponse, error) in
            
            if let responseData = data{
                
                do {
                    let result = try JSONDecoder.init().decode([GitNode].self, from: responseData)
                    completion(result)
                } catch  {
                    print(error)
                }
            }
        }
        dataTask.resume()
    }
}
