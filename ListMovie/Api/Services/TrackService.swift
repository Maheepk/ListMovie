//
//  TrackService.swift
//  ListMovie
//
//  Created by Maheep on 23/06/19.
//  Copyright © 2019 Maheep. All rights reserved.
//

import Foundation
import Alamofire

class TrackService {
    
    /**
     GET Track from server request
     */
    
    func getTrack(searchValue : String, success : ((_ response: TrackListResponse) -> Void)?, failure : @escaping failureBlock) {
        
        let urlStr = String.init(format: ServiceURL.SearchService.SEARCH_MOVIE_WITH_NAME, "\(searchValue)")
        
        Client().sendTheWebServiceAccordingToType(method: .get, urlString: urlStr, parameters: nil, headers: nil, encoding: JSONEncoding.default, success: { (response) in
            
            do {
                
                if let data = response.data{
                    self.showResult(data: data)
                    let result = try TrackListResponse(data: data)
                    success?(result)
                } else {
                    failure(Api.Error.emptyData)
                }
            } catch {
                log.debug(error)
                failure(error)
            }
            
        }) { (error) in
            failure(error)
        }
        
    }
    
    /*
     
     Show Result is used for Showing Data into Json Array or Dictionary..
     
     */
    
    func showResult(data : Data){
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? Dictionary<String,Any>
            {
                log.debug(jsonArray.first)
            } else {
                log.debug("bad json")
            }
        } catch let error as NSError {
            log.debug(error)
        }
    }
}


