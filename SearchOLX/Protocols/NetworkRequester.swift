//
//  NetworkRequester.swift
//  MyFeedback
//
//  Created by Javi on 3/16/16.
//  Copyright © 2016 FuzeIdea. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


protocol NetworkRequester {
    
    
}

public enum ResponseErrorType:Int {
    case nilResponse = 7000
    case tokenHasExpired
    case noRights
    case failStatus
    case httpResponseError
    case jsonHasInvalidFormat
    case serverIsOnMaintenance
}

extension NSError {
    convenience init(errorType:ResponseErrorType, message: String)  {
        let userInfo = NSDictionary(dictionary: [NSLocalizedDescriptionKey: message] )
        
        self.init(domain: "OLXErrorDomain", code: errorType.rawValue, userInfo: userInfo as [NSObject : AnyObject])
    }
    
}


extension NetworkRequester {
    
    //MARK: - Functions
    
    private func validateResponse (jsonData : NSDictionary?) -> NSError? {
        // Pending
        return nil
    }
    
    //MARK: - Alamofire functions
    func getAlamofireRequestForURLString (urlString:String) -> Request {
        let urlObject = NSURL(string: urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
        let mutableURLRequest = NSMutableURLRequest(URL: urlObject!)
        
        let manager = Alamofire.Manager.sharedInstance
        let request = manager.request(mutableURLRequest)
        
        return request
        
    }

    func executeGETRequestAndValidateResponse(urlString:String, successBlock: (json:JSON)->(), failBlock: (error:NSError)->() ){
        #if SHOW_REQUESTS
            log.debug(urlString)
        #endif
        getAlamofireRequestForURLString(urlString)
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseJSON { response in
            
            switch response.result {
            case .Success(let data):
                let json = JSON(data)

                successBlock(json: json)
            case .Failure(let error):
                failBlock(error: error)
            }

        }
        .response { (_,_,_,error) in
            if let _ = error {
                failBlock(error: NSError(errorType: ResponseErrorType.jsonHasInvalidFormat, message: error.debugDescription))
            }
        }
    }
    
}
