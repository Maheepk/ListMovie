//
//  RequestSerializer.swift
//  ListMovie
//
//  Created by Maheep on 22/06/19.
//  Copyright © 2019 Maheep. All rights reserved.
//

import Foundation
import Alamofire

extension ApiManager {
    
    static var Manager: Alamofire.SessionManager = {
        
        // Create custom manager
        
        let configuration = URLSessionConfiguration.default
        
        configuration.timeoutIntervalForRequest = 120
        
        let manager = Alamofire.SessionManager(configuration: configuration)
        
        return manager
        
    }()
    
    func request(method: HTTPMethod,
                 urlString: URLStringConvertible,
                 parameters: [String: Any]? = nil,
                 headers: [String: String]? = nil,
                 encoding : ParameterEncoding = URLEncoding.default,
                 completion: Completion?,failure :@escaping failureBlockWithResponse) -> Request? {
        
        guard Network.shared.isReachable else {
            failure(Api.Error.network, nil)
            return nil
        }
        
        var updatedHeaders = api.defaultHTTPHeaders
        updatedHeaders.updateValues(headers)
        
        
        log.debug("URL String : \(urlString.urlString)")
//        log.debug("Header Params : \(headers)")
//        //log.debug("Method : \(method)")
//        log.debug("Body Params : \(parameters)")
        //log.debug("Encoding : \(encoding)")
        
        let request = ApiManager.Manager.request(urlString.urlString, method: method, parameters: parameters, encoding: encoding, headers: updatedHeaders).responseJSON { response in
            
//            log.debug("Response : \(response)")
            
            switch response.result {
                
            case .success:
                completion?(response)
            case .failure(let error):
                failure(error, response)
            }
        }
        
        return request
    }
    
    
    func downloadRequest(method: HTTPMethod,
                         urlString: URLStringConvertible,
                         parameters: [String: Any]? = nil,
                         headers: [String: String]? = nil,
                         encoding : ParameterEncoding = URLEncoding.default,
                         destination : @escaping DownloadRequest.DownloadFileDestination,
                         completion: downloadCompletion?,progressValue:@escaping ProgressBlock,failure :@escaping failureBlockWithResponse) -> Request? {
        
        guard Network.shared.isReachable else {
            failure(Api.Error.network, nil)
            return nil
        }
        
        
        
        log.debug("URL String : \(urlString)")
        log.debug("Header Params : \(headers)")
        //log.debug("Method : \(method)")
        log.debug("Body Params : \(parameters)")
        //log.debug("Encoding : \(encoding)")
        
        
        let request = Alamofire.download(urlString as! URLConvertible, method : method, parameters: parameters, encoding: encoding, headers: headers, to: destination).validate()
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
                progressValue(progress)
            }
            .response(completionHandler: { (DefaultDownloadResponse) in
                
                log.debug(DefaultDownloadResponse.destinationURL)
                log.debug(DefaultDownloadResponse.response)
                if let error = DefaultDownloadResponse.error{
                    log.debug(DefaultDownloadResponse.error)
                    if let response = DefaultDownloadResponse.response{
                        let  err = NSError(code: response.statusCode, message: error.localizedDescription)
                        failure(err,nil)
                    }
                    else{
                        failure(error,nil)
                    }
                }
                else{
                    //if let error = DefaultDownloadResponse.response
                    completion?(DefaultDownloadResponse.response!)
                }
                
            })
        return request
    }
}
