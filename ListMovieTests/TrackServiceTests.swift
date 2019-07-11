//
//  TrackServiceTests.swift
//  ListMovieTests
//
//  Created by Maheep on 24/06/19.
//  Copyright © 2019 Maheep. All rights reserved.
//

import XCTest
@testable import ListMovie

class TrackServiceTests: XCTestCase {
    
    var trackService : TrackService!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        trackService = TrackService()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        trackService = nil
    }
    
    func testForApiService() {
        let expectation = self.expectation(description: "tesgt")
        trackService.getTrack(searchValue: "Rock", success: { (response) in
            XCTAssertNotNil(response)
            expectation.fulfill()
        }, failure: { (error) in
            XCTAssert(false, "Error")
            expectation.fulfill()
        })
        self.waitForExpectations(timeout: 3.0, handler: nil)
    }
}
