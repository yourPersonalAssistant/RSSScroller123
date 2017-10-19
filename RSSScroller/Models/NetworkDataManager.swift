//
//  NetworkDataManager.swift
//  RSSScroller
//
//  Created by admin on 10/18/17.
//  Copyright © 2017 admin. All rights reserved.
//

@objc protocol NetworkDataManagerDelegate {
    func dataWasDownloaded(rawNetworkData: Data)
}
import UIKit

class NetworkDataManager: NSObject {
    private var rawNetworkData: Data?

    var delegate: NetworkDataManagerDelegate?

    func downloadDataFromUrl(url: URL) {
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.get(url.absoluteString, parameters: nil, progress: nil,
                    success: {(operation: URLSessionDataTask!, responseObject: Any?) in
                        self.rawNetworkData = responseObject as? Data
                        self.delegate?.dataWasDownloaded(rawNetworkData: self.rawNetworkData!)
        },
                    failure: {(operation: URLSessionDataTask!, error: Error) in
                        print("Error: " + error.localizedDescription)
        })
    }
}
