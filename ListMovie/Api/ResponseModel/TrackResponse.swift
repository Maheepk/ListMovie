//
//  TrackResponse.swift
//  ListMovie
//
//  Created by Maheep on 23/06/19.
//  Copyright © 2019 Maheep. All rights reserved.
//

import Foundation

class TrackResponse: Codable {
    
    var trackId: Int64?
    var artistName : String?
    var artworkUrl100 : String?
    var trackName : String?
    var releaseDate : String?
    var primaryGenreName : String?
    var trackViewUrl : String?
    var trackPrice : Double?
    var currency:String?
    var longDescription:String?

    init() {
        
    }
    
    init(trackId : Int64?, artistName : String?, artworkUrl100 : String?, trackName : String?, releaseDate : String?, primaryGenreName : String?, trackViewUrl : String?, trackPrice : Double?, currency: String?, longDescription : String?  ) {
        
        self.trackId = trackId
        self.artistName = artistName
        self.artworkUrl100 = artworkUrl100
        self.trackName = trackName
        self.releaseDate = releaseDate
        self.primaryGenreName = primaryGenreName
        self.trackViewUrl = trackViewUrl
        self.trackPrice = trackPrice
        self.currency = currency
        self.longDescription = longDescription
    }
    
    convenience init(data: Data?) throws {
        let me = try newJSONDecoder().decode(TrackResponse.self, from: data!)
        self.init(trackId : me.trackId, artistName : me.artistName, artworkUrl100 : me.artworkUrl100, trackName : me.trackName, releaseDate : me.releaseDate, primaryGenreName : me.primaryGenreName, trackViewUrl : me.trackViewUrl, trackPrice: me.trackPrice, currency : me.currency, longDescription : me.longDescription)
    }
    
    func getModel(data: Data?) throws-> TrackResponse  {
        let me = try newJSONDecoder().decode(TrackResponse.self, from: data!)
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
