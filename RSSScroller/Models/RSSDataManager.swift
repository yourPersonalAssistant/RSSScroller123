//
//  RSSDataManager.swift
//  RSSScroller
//
//  Created by admin on 10/13/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class RSSDataManager: NSObject {
  private var feedURL: URL

    init(feedURL: URL) {
        self.feedURL = feedURL
    }

    func getRSSDataFromFeedURL(completion: @escaping (_ articles: [Article]) -> Void) {
    let downloader = DataDownloader()
        downloader.downloadDataFromUrl(url: feedURL, completion:{(rawNetworkData: Data) -> Void in

        let xmlParser = ScrollerXMLParser()
        xmlParser.startParsingContentFromData(rawNetworkData: rawNetworkData, completion: {(listOfRawParsedArticles: [Dictionary<String, String>]) -> Void in
            var articles: [Article] = []

            for rawParsedArticle in listOfRawParsedArticles {
                let article = Article()
                article.title = rawParsedArticle["title"]
                article.url = URL(string: rawParsedArticle["link"]!)!
                articles.append(article)
            }
            completion(articles)
        })

    })
  }
}
