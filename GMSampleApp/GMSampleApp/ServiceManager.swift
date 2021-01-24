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
        
        // https://api.github.com/repos/{user}/{repo}/commits?per_page={count}
        let urlString = String("\(Constants.Service.baseUrl)/repos/\(Constants.Service.repoName)/commits?per_page=\(Constants.Service.numberOfCommits)")
        guard let requestUrl = URL(string: urlString) else { return completion(nil)}
        
        
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
