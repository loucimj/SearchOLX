//
//  Service.swift
//  qeeptouch
//
//  Created by Javi on 4/17/16.
//  Copyright © 2016 QeepTouch. All rights reserved.
//
import Foundation
import SwiftyJSON


enum ServiceErrorType:Int {
    case notConnectedToNetwork = 8000
    case responseDoesNotContainExpectedResult
}

extension NSError {
    convenience init(errorType:ServiceErrorType, message: String)  {
        let userInfo = NSDictionary(dictionary: [NSLocalizedDescriptionKey: message] )
        
        self.init(domain: "ErrorDomain", code: errorType.rawValue, userInfo: userInfo as [NSObject : AnyObject])
    }
    
}


class Service: NetworkRequester {
    
    var baseURLString = "https://api-v2.olx.com/"
    
    // function for parsing  dict
    
    func search( searchString:String, successBlock: (json:JSON) ->(), failBlock: (error: NSError) -> ()  ) {
        
        executeGETRequestAndValidateResponse(baseURLString+"/items?location=www.olx.com.ar&searchTerm=\(searchString)", successBlock: successBlock, failBlock: failBlock)
        
    }
}

