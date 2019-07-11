//
//  RealmSwift.swift
//  ListMovie
//
//  Created by Maheep on 23/06/19.
//  Copyright © 2019 Maheep. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

@objcMembers class StoredTrack: Object, Decodable {
    
    dynamic var trackId: String = ""
    dynamic var artistName: String = ""
    dynamic var artworkUrl100: String = ""
    dynamic var trackName: String = ""
    dynamic var releaseDate: String = ""
    dynamic var primaryGenreName: String = ""
    dynamic var trackViewUrl: String = ""
    dynamic var trackPrice: String = ""
    dynamic var currency: String = ""
    dynamic var longDescription: String = ""

    enum CodingKeys: String, CodingKey {
        case trackId
        case artistName
        case artworkUrl100
        case trackName
        case releaseDate
        case primaryGenreName
        case trackViewUrl
        case trackPrice
        case currency
        case longDescription
    }
    
    required init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        trackId = try container.decode(String.self, forKey: .trackId)
        artistName = try container.decode(String.self, forKey: .artistName)
        artworkUrl100 = try container.decode(String.self, forKey: .artworkUrl100)
        trackName = try container.decode(String.self, forKey: .trackName)
        releaseDate = try container.decode(String.self, forKey: .releaseDate)
        primaryGenreName = try container.decode(String.self, forKey: .primaryGenreName)
        trackViewUrl = try container.decode(String.self, forKey: .trackViewUrl)
        trackPrice = try container.decode(String.self, forKey: .trackPrice)
        currency = try container.decode(String.self, forKey: .currency)
        longDescription = try container.decode(String.self, forKey: .longDescription)

        super.init()
    }
        
    required init()
    {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema)
    {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema)
    {
        super.init(realm: realm, schema: schema)
    }
}
