//
//  DataDownloader.swift
//  RSSScroller
//
//  Created by admin on 10/18/17.
//  Copyright © 2017 admin. All rights reserved.
//
import UIKit

class DataDownloader: NSObject {
    func downloadDataFromUrl(url: URL, completion: @escaping (_ rawNetworkData: Data) -> Void) {
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        
        manager.get(url.absoluteString, parameters: nil, progress: nil,
                    success: {(operation: URLSessionDataTask!, responseObject: Any?) in
                        let rawNetworkData = responseObject as? Data
                        completion(rawNetworkData!)
        },
                    failure: {(operation: URLSessionDataTask!, error: Error) in
                        print("Error: " + error.localizedDescription)
        })
    }
}
