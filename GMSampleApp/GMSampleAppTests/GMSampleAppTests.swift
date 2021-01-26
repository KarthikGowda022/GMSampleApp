//
//  GMSampleAppTests.swift
//  GMSampleAppTests
//
//  Created by K Madeve Gowda on 23/01/21.
//  Copyright © 2021 sheela. All rights reserved.
//

import XCTest
@testable import GMSampleApp

class MockServiceManger: GitHubApiClient {
    
    func fetchGitCommits(repoName: String,
                         onSuccess:@escaping GitHubGetUserCallback,
                         onError:@escaping ErrorCallback){

        let author1 = Author(name: "KarthikGowda022", email: "karthik.sm022@gmail.com", date: "2021-01-24T07:19:28Z")
        let author2 = Author(name: "K Madeve Gowda", email: "sheelakarthik@Ks-MacBook-Pro.local", date: "2021-01-26T07:43:45Z")
        
        let firstCommit = GitNode(nodeId: "MDY6Q29tbWl0MzMyMzg5OTU5OmIwZmFkNzIyYjAyZmQzYTQwNjQ5OTZhZjM5NzYwNGVmMmY4YmUxMzY=", sha: "b0fad722b02fd3a4064996af397604ef2f8be136", commit: GitCommit(author:author1 , committer: author1, message: "Initial commit"))
        
        let recentCommit = GitNode(nodeId: "MDY6Q29tbWl0MzMyMzg5OTU5OmIwZmFkNzIyYjAyZmQzYTQwNjQ5OTZhZjM5NzYwNGVmMmY4YmUxMzY=", sha: "b0fad722b02fd3a4064996af397604ef2f8be136", commit: GitCommit(author:author2 , committer: author2, message: "Added error handling and code cleanup"))
        
        onSuccess([recentCommit, firstCommit])
    }
    
}
class GMSampleAppTests: XCTestCase {

    let serviceManager:ServiceManager = ServiceManager.sharedManager
    let mockManager:MockServiceManger = MockServiceManger()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testSuccessfullFetchGitCommits(){
        var fetchResults = [GitNode]()
        let expec = expectation(description: "Fetch successful")
        
        serviceManager.fetchGitCommits(repoName: Constants.Service.repoName, onSuccess: { (result) in
            fetchResults = result
            expec.fulfill()
        }) { (error) in
            
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            XCTAssertNotNil(fetchResults, "Service returned empty respnse")
        }
        
    }

    func testFirstCommit(){
        var mockResults = [GitNode]()
        
        mockManager.fetchGitCommits(repoName: "", onSuccess: { (mockValue) in
            mockResults = mockValue
        }) { (error) in
            
        }
        
        var fetchResults = [GitNode]()
        let expec = expectation(description: "Fetch successful")
        
        serviceManager.fetchGitCommits(repoName: Constants.Service.repoName, onSuccess: { (result) in
            fetchResults = result
            expec.fulfill()
        }) { (error) in
            
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            XCTAssertNotNil(fetchResults, "Service returned empty respnse")
            let mockFirstCommit = mockResults.last!
            if let firstCommit = fetchResults.last {
                XCTAssert(firstCommit.sha == mockFirstCommit.sha, "First commit did not match")
            }
        }
        
    }
}
