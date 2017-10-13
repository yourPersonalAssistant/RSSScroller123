//
//  ScrollerXMLParser.swift
//  RSSScroller
//
//  Created by admin on 10/11/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

@objc protocol anXMLParserDelegate {
    func parsingWasFinished()
}

class ScrollerXMLParser: NSObject, XMLParserDelegate {


    var arrParsedData = [Dictionary<String, String>]()
    var currentDataDictionary = Dictionary<String, String>()
    var currentElement = ""
    var foundCharacters = ""

    var delegate: anXMLParserDelegate?

    
    func startParsingContentFromURL(rssURL: URL) {
        let parser = XMLParser(contentsOf: rssURL)
        parser?.delegate = self
        parser?.parse()
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

            /*if elementName == "link" {
                foundCharacters = (foundCharacters as NSString).substring(from: 3)
            }*/

            currentDataDictionary[currentElement] = foundCharacters

            foundCharacters = ""

            if currentElement == "pubDate" {
                arrParsedData.append(currentDataDictionary)
            }
        }
    }

    func parserDidEndDocument(_ parser: XMLParser) {
        delegate?.parsingWasFinished()
    }

    // Error Reporting.
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError)
    }

    func parser(_ parser: XMLParser, validationErrorOccurred validationError: Error) {
        print(validationError)
    }
}
