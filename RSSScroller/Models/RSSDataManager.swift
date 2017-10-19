//
//  XMLData.swift
//  RSSScroller
//
//  Created by admin on 10/13/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

@objc protocol RSSDataManagerDelegate {
  func dataLoaded(articles: [Article])
}

class RSSDataManager: NSObject {
  private var feedURL: URL
  public var delegate: RSSDataManagerDelegate?

    init(feedURL: URL) {
        self.feedURL = feedURL
    }

  func getRSSDataFromFeedURL() {
    let networkDataManager = NetworkDataManager()
    networkDataManager.delegate = self
    networkDataManager.downloadDataFromUrl(url: feedURL)
  }
}

// MARK: - ScrollerXMLParserDelegate
extension RSSDataManager: ScrollerXMLParserDelegate {
    func parsingWasFinished(listOfRawParsedArticles: [Dictionary<String, String>]) {
    var articles: [Article] = []

    for rawParsedArticle in listOfRawParsedArticles {
      let article = Article()
      article.title = rawParsedArticle["title"]
        article.url = URL(string: rawParsedArticle["link"]!)!
      articles.append(article)
    }

    delegate?.dataLoaded(articles: articles)
  }
}

//MARK: - NetworkDataManagerDelegate
extension RSSDataManager: NetworkDataManagerDelegate {
    func dataWasDownloaded(rawNetworkData: Data) {
        let xmlParser = ScrollerXMLParser()
        xmlParser.delegate = self
        xmlParser.startParsingContentFromData(rawNetworkData: rawNetworkData)
    }
}
