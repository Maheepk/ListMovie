//
//  Utils.swift
//  FlickFeedTestMVVM
//
//  Created by Maheep on 06/06/19.
//  Copyright © 2019 Maheep. All rights reserved.
//

import Foundation

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

class Utils {
    
    // Covert Date formatter
    class func formatDateDDMMYYYY(_ myString: String?)-> String {
        
        let dateFormatter: DateFormatter = DateFormatter()
        
        //2016-11-23T08:00:00Z
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let emptyDate = ""
        guard let dateString = myString else
        {
            return(emptyDate)
        }
        guard dateString != "NA" else
        {
            return(emptyDate)
        }
        guard let date = dateFormatter.date(from: dateString) else
        {
            return(emptyDate)
        }
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        return dateFormatter.string(from: date)
    }
}
