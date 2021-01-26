//
//  ServiceManager.swift
//  GMSampleApp
//
//  Created by K Madeve Gowda on 23/01/21.
//  Copyright © 2021 sheela. All rights reserved.
//

import Foundation

class ServiceManager: GitHubApiClient{
    
    static let sharedManager = ServiceManager()
    
    enum NetworkError: Error {
           case badUrl
           case responseError
           case responseNoData
           case decodeError
       }
    
    func fetchGitCommits(repoName: String,
                              onSuccess: @escaping GitHubGetUserCallback,
                              onError: @escaping ErrorCallback){
        // https://api.github.com/repos/{user}/{repo}/commits?per_page={count}
        let urlString = String("\(Constants.Service.baseUrl)/repos/\(repoName)/commits?per_page=\(Constants.Service.numberOfCommits)")
        guard let requestUrl = URL(string: urlString) else { return onError(NetworkError.badUrl)}
        
        
        let dataTask = URLSession.shared.dataTask(with: requestUrl) { (data, urlResponse, error) in
            
            if let responseData = data{
                
                do {
                    let result:[GitNode] = try JSONDecoder.init().decode([GitNode].self, from: responseData)
                    onSuccess(result)
                } catch  {
                    onError(NetworkError.decodeError)
                }
            }
        }
        dataTask.resume()
    }
}
