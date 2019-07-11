//
//  APIUrls.swift
//  ListMovie
//
//  Created by Maheep on 22/06/19.
//  Copyright © 2019 Maheep. All rights reserved.
//

import Foundation

struct ServiceURL {

    struct SearchService{
        static let SEARCH_MOVIE_WITH_NAME = ServiceURL().Environment() + "search?term=%@&media=movie&limit=200"
    }
    
    // Base URL with respect to App Environment
    func Environment() -> String
    {
        //        switch HPBUtil.loadEnvironment() {
        //        }
        return "https://itunes.apple.com/"
    }
}
