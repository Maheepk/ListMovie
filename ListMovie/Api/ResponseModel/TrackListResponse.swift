//
//  TrackListResponse.swift
//  ListMovie
//
//  Created by Maheep on 23/06/19.
//  Copyright © 2019 Maheep. All rights reserved.
//

import Foundation

class TrackListResponse: Codable {
    
    var resultCount: Int?
    var results : [TrackResponse]?
    
    init() {
        
    }
    
    init(resultCount : Int?, results : [TrackResponse]?) {
        
        self.resultCount = resultCount
        self.results = results
    }
    
    convenience init(data: Data?) throws {
        let me = try newJSONDecoder().decode(TrackListResponse.self, from: data!)
        self.init(resultCount : me.resultCount, results : me.results)
    }
    
    func getModel(data: Data?) throws-> TrackListResponse  {
        let me = try newJSONDecoder().decode(TrackListResponse.self, from: data!)
        return me
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    func jsonData() throws -> Data? {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: (try self.jsonData())!, encoding: encoding)
    }
    
}
