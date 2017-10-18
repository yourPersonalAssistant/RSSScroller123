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
  public var delegate: RSSDataManagerDelegate?

  func getRSSDataFromFeedURL(feedURL: URL) {
    let xmlParser = ScrollerXMLParser()
    xmlParser.delegate = self
    xmlParser.startParsingContentFromURL(rssURL: feedURL)
  }
}

// MARK: anXMLParserDelegate
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
