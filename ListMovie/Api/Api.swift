//
//  Api.swift
//  ListMovie
//
//  Created by Maheep on 22/06/19.
//  Copyright © 2019 Maheep. All rights reserved.
//

import Foundation

final class Api {
    struct Path {
        
        #if DEBUG_DEV
        static let baseURL = ""
        #elseif DEBUG_PROD
        static let baseURL = ""
        #else
        static let baseURL = ""
        #endif
    }
}

protocol URLStringConvertible {
    var urlString: String { get }
}

protocol ApiPath: URLStringConvertible {
    static var path: String { get }
}

extension URL: URLStringConvertible {
    var urlString: String { return absoluteString }
}

extension Int: URLStringConvertible {
    var urlString: String { return String(describing: self) }
}

private func / (lhs: URLStringConvertible, rhs: URLStringConvertible) -> String {
    return lhs.urlString + "/" + rhs.urlString
}

extension String: URLStringConvertible {
    var urlString: String { return self }
}

extension CustomStringConvertible where Self: URLStringConvertible {
    var urlString: String { return description }
}

