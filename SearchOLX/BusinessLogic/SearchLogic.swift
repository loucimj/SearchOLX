//
//  SearchLogic.swift
//  SearchOLX
//
//  Created by Javi on 5/13/16.
//  Copyright © 2016 FuzeIdea. All rights reserved.
//

import Foundation


protocol SearchLogic {
    func searchDidHaveProblems(error:NSError)
    func searchDidFinish(items:Array<SearchResultItem>)
}

extension SearchLogic {
    
    //MARK: - Default implementations
    func searchDidHaveProblems(error:NSError) {
        print("\(error)")
    }
    
    func searchDidFinish(items:Array<SearchResultItem>) {
        //Should be overriden by the class using the protocol
    }
    
    //MARK: - Functions
    func searchItems(searchQuery:String) {
        let service = Service()
        
        service.search(searchQuery,
            successBlock: { json in
                
                if let data = json["data"].array {
                    var searchResults = Array<SearchResultItem>()
                    
                    for item in data {
                        var searchItem = SearchResultItem()
                        searchItem.title = item["title"].string ?? ""
                        searchItem.imageURL = item["fullImage"].string ?? ""
                        let priceInfo = item["price"]
                        searchItem.price = priceInfo["amount"].double ?? 0
                        searchItem.priceLabel = priceInfo["displayPrice"].string ?? ""
                        searchResults.append(searchItem)
                    }
                    self.searchDidFinish(searchResults)
                } else {
                    let error = NSError(errorType: ServiceErrorType.responseDoesNotContainExpectedResult, message: "Response does not contain expected result")
                    self.searchDidHaveProblems(error)
                }
            },
            failBlock: { error in
                self.searchDidHaveProblems(error)
            }
        )
    }
}