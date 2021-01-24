//
//  GitNode.swift
//  GMSampleApp
//
//  Created by K Madeve Gowda on 23/01/21.
//  Copyright © 2021 sheela. All rights reserved.
//

import Foundation

struct GitNode: Codable {
    
    //var gitId:UInt32
    var nodeId:String
    var sha:String
    var commit:GitCommit

    
    private enum CodingKeys:String, CodingKey{
        
        case nodeId = "node_id"
        case sha = "sha"
        case commit = "commit"
    }
}

struct GitCommit: Codable {
    
    var author: Author
    var committer: Author
    var message: String
    
    private enum CodingKeys:String, CodingKey{
        
        case author = "author"
        case message = "message"
        case committer = "committer"
    }
}


struct Author: Codable {
    var name:String
    var email:String
    var date:String
    
    private enum CodingKeys:String, CodingKey{
        
        case name = "name"
        case email = "email"
        case date = "date"
    }
}
