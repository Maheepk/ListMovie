//
//  Client.swift
//  ListMovie
//
//  Created by Maheep on 22/06/19.
//  Copyright © 2019 Maheep. All rights reserved.
//

import UIKit
import Alamofire

class Client: NSObject {
    
    var requestAPI : Request?
    
    var previousEncoding : ParameterEncoding = JSONEncoding.default
    
    var _successBlock : Completion?
    var _failureBlock : failureBlock?
    
    // Main function for Calling all Apis .
    
    func sendTheWebServiceAccordingToType(method: HTTPMethod,
                                          urlString: URLStringConvertible,
                                          parameters: [String: Any]? = nil,
                                          headers: [String: String]? = nil,
                                          encoding: ParameterEncoding = URLEncoding.default,
                                          success: @escaping Completion,failure :@escaping failureBlock) {
        
        let apiManager = ApiManager()
        
        self.previousEncoding = encoding
        
        self._successBlock = success
        self._failureBlock = failure
        
        requestAPI = apiManager.request(method: method, urlString: urlString, parameters: parameters, headers: headers, encoding:encoding, completion: { (response) in
            
            success(response)
            
        }) { (error, response) in
            
            
            //            log.debug(error)
            
            switch error.code {
            case 400,402,405..<500:break;
            //                self.handleBadRequest(response)
            case 401:break;
                // Calling refresh Token Api.
            //                self.handleReAuthToken(self.requestAPI!)
            case 403:break;
                // We are Showing Forbidden Error
            //                self.handleUnAuthToken(response)
            case 404:break;
            //                self.handleNotFoundError(response)
            case 500..<600 :break;
            //                self.handleInternalServerError(response)
            case NSURLErrorNotConnectedToInternet :
                self._failureBlock?(Api.Error.network)
            default :
                self._failureBlock?(Api.Error.serverError)
            }
            
        }
    }
    
    
}
