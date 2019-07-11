//
//  Error.swift
//  ListMovie
//
//  Created by Maheep on 22/06/19.
//  Copyright © 2019 Maheep. All rights reserved.
//

import Foundation
import Alamofire


typealias Network = NetworkReachabilityManager

let DomainError = "DomainError"

// MARK: - Network
extension Network {
    static let shared: Network = {
        guard let manager = Network() else {
            fatalError("Cannot alloc network reachability manager!")
        }
        return manager
    }()
}

extension Api {
    struct Error {
        static let emptyData = NSError(domain: Api.Path.baseURL, code: 997, message: "Something went wrong.")
        static let noResponse = NSError(status: .noResponse)
        static let network = NSError(domain: NSCocoaErrorDomain,code :NSURLErrorNotConnectedToInternet , message: "Please check your connection, connect to WiFi or buy data and try again.")
        static let serverError = NSError(domain: NSCocoaErrorDomain, code: NSURLErrorBadServerResponse, message: "The service is currently unavailable, please try again")
        
    }
    
}


extension Error {
    func show() {
        let `self` = self as NSError
        self.show()
    }
    
    public var code: Int {
        let `self` = self as NSError
        return self.code
    }
    
}
