//
//  ListMovieTests.swift
//  ListMovieTests
//
//  Created by Maheep on 22/06/19.
//  Copyright © 2019 Maheep. All rights reserved.
//

import XCTest
@testable import ListMovie

class ListMovieTests: XCTestCase {

    var trackViewModel : TrackViewModel!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        trackViewModel = TrackViewModel(self)
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        trackViewModel = nil
    }

    func testForFetchTrackFromServer() {
        
        self.measure {
            // Put the code you want to measure the time of here.
            trackViewModel.getFromServerDB("Rock")
        }

    }

    func testForFetchTrackFromLocal() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            
           trackViewModel.getFromLocalDB("Rock")
        }
    }
 
    func testForFetchTrackLocalEmptyValue() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.

            trackViewModel.getFromLocalDB("")
        }
    }
}

extension ListMovieTests : TrackViewModelDelegate {
    
    func trackDataGetError(_ error: Error?) {
        
        // Checking for Data froming to Track View Model..
        XCTAssert(error != nil, "Data Not coming from Server")
    }
    
    func trackData(_ viewModel: TrackViewModel?) {

        // Checking for Data froming to Track View Model..
        XCTAssert(viewModel!.trackViewModel.count > 0, "Data coming from Server")
        
        // Check for Track View Model Values
        
        XCTAssertTrue(viewModel!.trackViewModel.first?.artistName != nil, "Artist Name : \( viewModel!.trackViewModel.first?.artistName)")
        XCTAssertTrue(viewModel!.trackViewModel.first?.movieName != nil, "Movie Name : \(viewModel!.trackViewModel.first?.movieName)")
        XCTAssertTrue(viewModel!.trackViewModel.first?.artworkUrl != nil, "Artist URL : \(viewModel!.trackViewModel.first?.artworkUrl)")
        XCTAssertTrue(viewModel!.trackViewModel.first?.genreName != nil, "Genre : \(viewModel!.trackViewModel.first?.genreName)")
    }
}
