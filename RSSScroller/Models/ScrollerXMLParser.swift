//
//  ScrollerXMLParser.swift
//  RSSScroller
//
//  Created by admin on 10/11/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class ScrollerXMLParser: NSObject, XMLParserDelegate {
  private var currentDataDictionary = Dictionary<String, String>()
  private var currentElement = ""
  private var foundCharacters = ""
  private var listOfRawParsedArticles = [Dictionary<String, String>]()
  private var parsingCompletionHandler: ((_ listOfRawParsedArticles: [Dictionary<String,String>]) -> Void)?

    func startParsingContentFromData(rawNetworkData: Data, completion:@escaping (_ listOfRawArticles: [Dictionary<String,String>]) -> Void) {
    let parser = XMLParser(data: rawNetworkData)
    parser.delegate = self
    parsingCompletionHandler = completion
    parser.parse()
  }

  func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]){
    currentElement = elementName
  }

  func parser(_ parser: XMLParser, foundCharacters string: String) {
    if currentElement == "title" || currentElement == "link" || currentElement == "pubDate" {
      foundCharacters += string
    }
  }

  func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    if !foundCharacters.isEmpty {
      currentDataDictionary[currentElement] = foundCharacters

      foundCharacters = ""

      if currentElement == "pubDate" {
        listOfRawParsedArticles.append(currentDataDictionary)
      }
    }
  }

  func parserDidEndDocument(_ parser: XMLParser) {
    parsingCompletionHandler!(listOfRawParsedArticles)
  }

  // Error Reporting.
  func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
    print(parseError)
  }

  func parser(_ parser: XMLParser, validationErrorOccurred validationError: Error) {
    print(validationError)
  }
}
